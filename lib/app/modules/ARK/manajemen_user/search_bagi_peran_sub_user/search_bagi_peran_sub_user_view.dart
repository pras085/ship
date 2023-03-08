import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/create_manajemen_role/create_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

import 'search_bagi_peran_sub_user_controller.dart';

class SearchBagiPeranSubUserView
    extends GetView<SearchBagiPeranSubUserController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: willpop,
        child: Container(
          color: Colors.white,
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
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 8),
                    ),
                  ], color: Colors.white),
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
                                    onTap: willpop,
                                    child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            "ic_back_blue_button.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24))),
                            SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Obx(() => CustomTextField(
                                      enabled: !controller.isLoadingData.value
                                          ? true
                                          : false,
                                      context: Get.context,
                                      autofocus: true,
                                      controller:
                                          controller.searchController.value,
                                      textInputAction: TextInputAction.search,
                                      onTap: () {
                                        controller.lastShow.value = true;
                                        controller.onChangeText(controller
                                            .searchController.value.text);
                                      },
                                      onChanged: (value) {
                                        controller.onChangeText(value);
                                      },
                                      onEditingComplete: () {
                                        controller.onSearch();
                                      },
                                      textSize: 14,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      newInputDecoration: InputDecoration(
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText:
                                            "ManajemenUserIndexCariSubUser"
                                                .tr, // Cari User
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Obx(() => controller
                                            .isShowClearSearch.value
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.onClearSearch();
                                            },
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    right: GlobalVariable.ratioWidth(Get.context) *
                                                        4),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        "ic_close_blue.svg",
                                                    color: Colors.black,
                                                    width:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                    height:
                                                        GlobalVariable.ratioWidth(Get.context) * 24)))
                                        : SizedBox.shrink()),
                                  ),
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
              ),
              body: Obx(
                () =>
                    controller.lastShow.value ? _listLastSearch() : _listUser(),
              ),
            ),
          ),
        ));
  }

  Widget _listLastSearch() {
    return Container(
      margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      "ProsesTenderIndexLabelTerakhirDicari"
                          .tr, // Terakhir dicari
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  GestureDetector(
                    onTap: controller.clearHistorySearch,
                    child: CustomText(
                        "ProsesTenderIndexLabelHapusSemua".tr, // Hapus Semua
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorRed2)),
                  )
                ],
              )),
          Obx(() => !controller.isLoadingLast.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < controller.listHistorySearch.length;
                        index++)
                      GestureDetector(
                          onTap: () {
                            controller.chooseHistorySearch(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 7,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "pencarianterakhir.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                Expanded(
                                    child: CustomText(
                                        controller.listHistorySearch[index]
                                            ['search'],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                GestureDetector(
                                    onTap: () {
                                      controller.hapusHistorySearch(index);
                                    },
                                    child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            "ic_close.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16)),
                              ],
                            ),
                          )),
                  ],
                )
              : Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }

  Widget _listUser() {
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
                        top: controller.searchOn.value
                            ? GlobalVariable.ratioWidth(Get.context) * 20
                            : 0,
                        bottom: (controller.listUser.length == 0 &&
                                !controller.isLoadingData
                                    .value) // ni muncul ketika belum ada info pra tender
                            ? GlobalVariable.ratioWidth(Get.context) * 0
                            : GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      child: controller.searchController.value.text != "" &&
                              !controller.isLoadingData.value &&
                              controller.searchOn.value
                          ? Container(
                              child: controller.listUser.length > 0
                                  ? RichText(
                                      text: TextSpan(
                                          text: "ManajemenUserIndexDitemukanHasilPencarian1"
                                                  .tr +
                                              " " +
                                              GlobalVariable
                                                      .formatCurrencyDecimal(
                                                          controller
                                                              .jumlahDataUser
                                                              .toString())
                                                  .toString() +
                                              " " +
                                              "ManajemenUserIndexDitemukanHasilPencarian2"
                                                  .tr +
                                              " \"", // Menampilkan hasil untuk
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color:
                                                Color(ListColor.colorDarkBlue2),
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: controller
                                                    .searchController
                                                    .value
                                                    .text,
                                                style: TextStyle(
                                                  fontFamily: "AvenirNext",
                                                  color: Colors.black,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "\"", // Menampilkan hasil untuk
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "AvenirNext",
                                                        color: Color(ListColor
                                                            .colorDarkBlue2),
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ])
                                          ]),
                                    )
                                  : RichText(
                                      text: TextSpan(
                                          text: "ManajemenUserIndexTidakDitemukanHasilPencarian"
                                                  .tr +
                                              " ", //Tidak ditemukan hasil pencarian untuk
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color:
                                                Color(ListColor.colorDarkBlue2),
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "\"" +
                                                    controller.searchController
                                                        .value.text +
                                                    "\"",
                                                style: TextStyle(
                                                  fontFamily: "AvenirNext",
                                                  color: Colors.black,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: "",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "AvenirNext",
                                                        color: Color(ListColor
                                                            .colorDarkBlue2),
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      children: [])
                                                ])
                                          ]),
                                    ))
                          : SizedBox()),
                  Expanded(child: _showlistUser()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showlistUser() {
    return Stack(children: [
      //KALAU MASIH LOADING
      Obx(() => controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA
          (controller.listUser.length == 0 && !controller.isLoadingData.value)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        GlobalVariable.imagePath +
                            "ic_pencarian_tidak_ditemukan.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82,
                        height: GlobalVariable.ratioWidth(Get.context) * 93),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'ManajemenUserIndexKeywordTidakDitemukan'.tr +
                            '\n' +
                            'ManajemenUserIndexDiSistem'
                                .tr, //Keyword tidak ditemukan disistem,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : ListView.builder(
                  itemCount: controller.listUser.length,
                  itemBuilder: (content, index) {
                    return cardTile(Get.context, index);
                  }))
    ]);
  }

  Widget cardTile(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
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
                  GlobalVariable.ratioWidth(Get.context) * 7,
                  GlobalVariable.ratioWidth(Get.context) * 13,
                  GlobalVariable.ratioWidth(Get.context) * 7),
              decoration: BoxDecoration(
                  // color: GlobalVariable.cardHeaderManajemenColor,
                  color: GlobalVariable.cardHeaderManajemenColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(GlobalVariable.imagePath + "user_admin.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  Expanded(
                      child: Container(
                    child: Wrap(children: [
                      CustomText(
                        controller.listUser[index]['name'],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
                  )),
                  Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 5,
                  ),
                  Obx(() => GestureDetector(
                      onTap: () {
                        if (controller.usedUser.value < controller.quotaUser &&
                            !controller.listUser[index]['aktif']) {
                          controller.usedUser.value++;
                          controller.listUser[index]['aktif'] =
                              !controller.listUser[index]['aktif'];
                          controller.listUser.refresh();
                          controller.isChanged.value = true;
                          print('a');
                        } else if (controller.usedUser.value > 0 &&
                            controller.listUser[index]['aktif']) {
                          controller.usedUser.value--;
                          controller.listUser[index]['aktif'] =
                              !controller.listUser[index]['aktif'];
                          controller.listUser.refresh();
                          controller.isChanged.value = true;
                          print('b');
                          controller
                              .removeData(controller.listUser[index]['id']);
                        }
                        controller.onSetData();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                            controller.listUser[index]['aktif']
                                ? GlobalVariable.imagePath + "Toggle on.svg"
                                : GlobalVariable.imagePath + "Toggle off.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 40,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ))),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 17,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10),
                      bottomRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 8,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                              ListColor.colorLightGreen2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6,
                              ),
                            ),
                          ),
                          child: CustomText('ManajemenUserIndexAktif'.tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorGreen6)),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 13,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + "Email.svg",
                                      color: Color(ListColor.colorBlue),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16)),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                  child: Container(
                                      child: CustomText(
                                controller.listUser[index]['email'],
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                wrapSpace: true,
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorLightGrey4),
                              )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 6,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          1),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + "Whatsapp.svg",
                                      color: Color(ListColor.colorBlue),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16)),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                  child: CustomText(
                                controller.listUser[index]['phone'],
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14,
                                wrapSpace: true,
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorLightGrey4),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 14,
                        ),
                        Obx(
                          () => DropdownBelow(
                            itemWidth:
                                GlobalVariable.ratioWidth(Get.context) * 214,
                            itemTextstyle: TextStyle(
                                color: Color(ListColor.colorGrey3),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        14),
                            boxTextstyle: TextStyle(
                                color: Color(ListColor.colorLightGrey4),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        14),
                            boxPadding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 17,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    15),
                            boxWidth:
                                GlobalVariable.ratioWidth(Get.context) * 214,
                            boxHeight:
                                GlobalVariable.ratioWidth(Get.context) * 40,
                            boxDecoration: BoxDecoration(
                              color: controller.listUser[index]['aktif']
                                  ? Colors.white
                                  : Color(ListColor.colorLightGrey2),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6),
                              border: Border.all(
                                width: 1,
                                // color: Color(ListColor.colorGrey2))),
                                color: controller.listUser[index]['ddError'] &&
                                        controller.listUser[index]['aktif']
                                    ? Color(ListColor.colorRed)
                                    : Color(ListColor.colorGrey2),
                              ),
                            ),
                            icon: SvgPicture.asset(
                                GlobalVariable.imagePath + "Chevron Down.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24),
                            hint: CustomText(
                                controller.listUser[index]['role'] == ""
                                    ? "ManajemenUserBagiPeranPilihRole"
                                        .tr //Pilih Jenis Muatan
                                    : controller.listUser[index]['role'],
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(ListColor.colorLightGrey4)),
                            value: controller.listUser[index]['roleid'] == 0 ||
                                    !controller.listUser[index]['aktif']
                                ? null
                                : controller.listUser[index]['roleid'],
                            items: !controller.listUser[index]['aktif']
                                ? []
                                : [
                                    DropdownMenuItem(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          bottom: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              9,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey21),
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          "Plus.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16),
                                                  SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        6,
                                                  ),
                                                  CustomText(
                                                    "ManajemenUserBagiPeranTambahRole"
                                                        .tr,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                      value: 0,
                                    ),
                                    for (int i = 0;
                                        i < controller.listRole.length;
                                        i++)
                                      DropdownMenuItem(
                                        child: CustomText(
                                          controller.listRole[i]['name'],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        value: controller.listRole[i]['ID'],
                                      ),
                                  ],
                            onChanged: controller.listUser[index]['aktif']
                                ? (value) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();
                                    print(value);
                                    //FocusManager.instance.primaryFocus.unfocus();
                                    // controller.jenisMuatan.value = value;
                                    if (value > 0) {
                                      controller.listUser[index]['roleid'] =
                                          value;
                                      controller.listUser[index]['role'] =
                                          controller.getRoleName(value);
                                      controller.listUser.refresh();
                                      controller.isChanged.value = true;
                                    } else {
                                      print(value);

                                      if (controller.isChanged.value) {
                                        popUpCreateRole();
                                      } else {
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                        Get.back();
                                        GetToPage.toNamed<
                                                ManajemenRoleController>(
                                            Routes.MANAJEMEN_ROLE);
                                        GetToPage.toNamed<
                                                CreateManajemenRoleController>(
                                            Routes.CREATE_MANAJEMEN_ROLE);
                                      }
                                    }

                                    controller.onSetData();
                                  }
                                : null,
                          ),
                        ),
                        controller.listUser[index]['ddError'] &&
                                controller.listUser[index]['aktif']
                            ? Container(
                                child: SingleChildScrollView(
                                    child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomText(
                                        "ManajemenUserBagiPeranAndaBelumMenentukanRoleUser"
                                            .tr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Color(ListColor.colorRed),
                                        height: 1.2,
                                      )),
                                    ],
                                  ),
                                ],
                              )))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void popUpCreateRole() async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderCreateLabelInfoKonfirmasiPembatalan"
            .tr, //Konfirmasi Pembatalan
        message:
            "ManajemenUserBagiPeranApakahAndaYakinInginMenambahkanRole".tr +
                " " +
                "ManajemenUserBagiPeranDataYangTelahDiisiTidakAkanDisimpan"
                    .tr, //Apakah anda yakin ingin menambahkan
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          Get.back();
          Get.back();
          Get.back();
          GetToPage.toNamed<ManajemenRoleController>(Routes.MANAJEMEN_ROLE);
          GetToPage.toNamed<CreateManajemenRoleController>(
              Routes.CREATE_MANAJEMEN_ROLE);
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  Future<bool> willpop() async {
    print(controller.listUserSelected.value);
    print('UTAMA');
    print(controller.listUserUtama.value);

    Get.back(result: [
      controller.listUserSelected.value,
      controller.listUserUtama.value
    ]);
  }
}
