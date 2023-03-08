import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchManajemenUserView extends GetView<SearchManajemenUserController> {
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
                                                .isShowClearSearch.value &&
                                            controller.lastShow.value
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.onClearSearch();
                                            },
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            4),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        "ic_close_blue.svg",
                                                    color: Colors.black,
                                                    width:
                                                        GlobalVariable.ratioWidth(Get.context) * 24,
                                                    height: GlobalVariable.ratioWidth(Get.context) * 24)))
                                        : SizedBox.shrink()),
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
                                  if (controller.listUser.length > 0) {
                                    controller.showSortingDialog();
                                  }
                                },
                                child: Obx(() => controller.listUser.length > 0
                                    ? controller.sortBy.value == ""
                                        ? SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                "ic_sorting_blue.svg",
                                            color: GlobalVariable
                                                .tabButtonMainColor,
                                            width: GlobalVariable.ratioWidth(Get.context) *
                                                24,
                                            height: GlobalVariable.ratioWidth(Get.context) *
                                                24)
                                        : SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                "ic_sort_black_on.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) *
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
          (controller.listUser.length == 0 &&
                  !controller.isLoadingData.value &&
                  !controller.kondisiAwal)
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
              : _listUserRefresher())
    ]);
  }

  Widget _listUserRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listUser.length == controller.countSearch.value
            ? false
            : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 10;
          await controller.getListUser(
              controller.countData.value, controller.jenisTab.value);
        },
        onRefresh: () async {
          controller.listUser.clear();
          controller.isLoadingData.value = true;
          await controller.getListUser(1, controller.jenisTab.value);
        },
        child: _listUserTile());
  }

  Widget _listUserTile() {
    return ListView.builder(
      itemCount: controller.listUser.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //KALAU DIA ADA DATA, MUNCUL DISINI, JIKA TIDAK
              GestureDetector(
                onTap: () async {},
                child: cardTile(content, index),
              )
            ]);
      },
    );
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
          border: controller.listUser[index]['status'] == -1
              ? Border.all(
                  color: Color(ListColor.colorBackgroundDisable),
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                )
              : null,
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
                  color: controller.listUser[index]['status'] != -1
                      ? GlobalVariable.appsMainColor
                      : Color(ListColor.colorBackgroundDisable),
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
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  controller.listUser[index]['status'] == 1
                      ? Container(
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
                        )
                      : Container(),
                  //status pending
                  controller.listUser[index]['status'] == 2 ||
                          controller.listUser[index]['status'] == 3 ||
                          controller.listUser[index]['status'] == 4
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 8,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                              ListColor.colorWarningTile,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6,
                              ),
                            ),
                          ),
                          child: CustomText('ManajemenUserIndexPending'.tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorOrange)),
                        )
                      : Container(),
                  //status tidak aktif
                  controller.listUser[index]['status'] == -1
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 8,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(
                              ListColor.colorBackgroundDisableTile,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6,
                              ),
                            ),
                          ),
                          child: CustomText('ManajemenUserIndexTidakAktif'.tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorBlack41)),
                        )
                      : Container(),
                  Container(
                    width: controller.listUser[index]['status'] != 2
                        ? 0
                        : GlobalVariable.ratioWidth(Get.context) * 5,
                  ),
                  (controller.listUser[index]['status'] == 2 &&
                              controller.listUser[index]['remaining_diff'] ==
                                  0) ||
                          controller.listUser[index]['status'] == 4
                      ? GestureDetector(
                          child: Container(
                              padding: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 2,
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
                            controller.opsi(controller.listUser[index], index);
                          })
                      : Container(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                color: controller.listUser[index]['status'] != -1
                    ? Colors.white
                    : Color(ListColor.colorBackgroundDisableTile),
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
                                      color: controller.listUser[index]
                                                  ['status'] !=
                                              -1
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorLightGrey4),
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
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorLightGrey4),
                              )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 12,
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
                                      color: controller.listUser[index]
                                                  ['status'] !=
                                              -1
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorLightGrey4),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
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
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorLightGrey4),
                              ))
                            ],
                          ),
                        ),
                      ],
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
                    color: controller.listUser[index]['status'] != -1
                        ? Colors.white
                        : Color(ListColor.colorBackgroundDisableTile),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 10),
                        bottomRight: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 10))),
                child: controller.listUser[index]['status'] == -1 ||
                        controller.listUser[index]['status'] == 1
                    ?
                    //bottom bar untuk status aktif/nonaktif
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // status belum ditugaskan
                          //status tidak aktif
                          controller.listUser[index]['status'] != 1
                              ? Expanded(child: Container())
                              : controller.listUser[index]['StatusAssign'] == 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          ListColor.colorBackgroundLabelBatal,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6,
                                          ),
                                        ),
                                      ),
                                      child: CustomText(
                                          'ManajemenUserIndexBelumDitugaskan'
                                              .tr,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(ListColor.colorRed)),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          ListColor.colorLightBlue3,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6,
                                          ),
                                        ),
                                      ),
                                      child: CustomText(
                                          'ManajemenUserIndexDitugaskan'.tr,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(ListColor.colorBlue)),
                                    ),
                          Obx(() => Container(
                                  child: Row(children: [
                                CustomText(
                                  controller.listUser[index]['status'] == 1
                                      ? "ManajemenUserIndexAktif".tr
                                      : "ManajemenUserIndexNonaktif".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                Obx(() => GestureDetector(
                                    onTap: () async {
                                      controller.cekAktifNon =
        await SharedPreferencesHelper.getHakAkses("Aktif/Nonaktifkan Sub User",denganLoading:true);
                                      if (SharedPreferencesHelper.cekAkses(
                                          controller.cekAktifNon)) {
                                        controller.aktifNonManajemenUser(
                                            controller.listUser[index]['id'],
                                            controller.listUser[index]['name'],
                                            index,
                                            (controller.listUser[index]
                                                        ['status'] ==
                                                    1
                                                ? false
                                                : true));
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                          controller.listUser[index]
                                                      ['status'] ==
                                                  1
                                              ? controller.cekAktifNon
                                                  ? GlobalVariable.imagePath +
                                                      "Toggle on.svg"
                                                  : GlobalVariable.imagePath +
                                                      "Toggle disabled.svg"
                                              : GlobalVariable.imagePath +
                                                  "Toggle off.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              40,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                    ))),
                              ]))),
                        ],
                      )
                    : controller.listUser[index]['status'] == 2
                        ?
                        //bottom bar untuk verifikasi email
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4,
                                ),
                                child: Wrap(children: [
                                  CustomText(
                                    "ManajemenUserIndexMenungguVerifikasiEmail"
                                        .tr,
                                    color: Color(ListColor.colorOrange),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  CustomText(
                                    controller.listUser[index]
                                                ['remaining_diff'] !=
                                            0
                                        ? (Duration(
                                                seconds:
                                                    controller.listUser[index]
                                                        ['remaining_diff'])
                                            .toString()
                                            .substring(
                                                2,
                                                Duration(
                                                            seconds: controller
                                                                        .listUser[
                                                                    index][
                                                                'remaining_diff'])
                                                        .toString()
                                                        .length -
                                                    7))
                                        : "00:00",
                                    color: Color(ListColor.colorLightGrey4),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  )
                                ]),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  controller.cekTambah = await SharedPreferencesHelper.getHakAkses("Tambah Sub User",denganLoading:true);
                                  if (SharedPreferencesHelper.cekAkses(
                                      controller.cekTambah)) {
                                    if (controller.listUser[index]
                                            ['remaining_diff'] ==
                                        0) {
                                      controller.kirimUlang(
                                          controller.listUser[index]['id'],
                                          index);
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4,
                                  ),
                                  child: CustomText(
                                    "ManajemenUserIndexKirimUlang".tr,
                                    color: 
                                    controller.cekTambah?
                                    controller.listUser[index]
                                                ['remaining_diff'] !=
                                            0
                                        ? Color(ListColor.colorLightGrey2)
                                        : Color(ListColor.colorBlue):
                                        Color(ListColor.colorAksesDisable),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4,
                                  ),
                                  child: controller.listUser[index]['status'] ==
                                          3
                                      ? CustomText(
                                          "ManajemenUserIndexMenungguVerifikasiNoWhatsapp"
                                              .tr,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(ListColor.colorOrange),
                                        )
                                      : CustomText(
                                          controller.listUser[index]
                                                      ['status'] ==
                                                  4
                                              ? "ManajemenUserIndexVerifikasiDitolakOlehSubUser"
                                                  .tr
                                              : "",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.colorRed4),
                                        ))
                            ],
                          ))
          ],
        ));
  }

  Future<bool> willpop() async {
    print(controller.mapSort);
    controller.onSave();
    Get.back(result: [
      controller.sortBy.value,
      controller.sortType.value,
      controller.mapSort,
      controller.sort
    ]);
  }
}
