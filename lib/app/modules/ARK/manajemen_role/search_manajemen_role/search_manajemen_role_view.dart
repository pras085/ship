import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/detail_manajemen_role/detail_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/edit_manajemen_role/edit_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/search_manajemen_role/search_manajemen_role_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchManajemenRoleView extends GetView<SearchManajemenRoleController> {
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
                                        hintText: "ManajemenRoleIndexCariRole"
                                            .tr, // Cari Role
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
                            SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller.listRole.length > 0) {
                                    controller.showSortingDialog();
                                  }
                                },
                                child: Obx(() => controller.listRole.length > 0
                                    ? controller.sortBy.value == ""
                                        ? SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                "sorting_active.svg",
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
              body: _listRole(),
            ),
          ),
        ));
  }

  Widget _listRole() {
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
                        bottom: (controller.listRole.length == 0 &&
                                !controller.isLoadingData
                                    .value) // ni muncul ketika belum ada info pra tender
                            ? GlobalVariable.ratioWidth(Get.context) * 0
                            : GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      child: controller.searchController.value.text != "" &&
                              !controller.isLoadingData.value &&
                              controller.searchOn.value
                          ? Container(
                              child: controller.listRole.length > 0
                                  ? RichText(
                                      text: TextSpan(
                                          text: "ManajemenRoleIndexDitemukanHasilPencarian"
                                                  .tr +
                                              " " +
                                              GlobalVariable
                                                      .formatCurrencyDecimal(
                                                          controller.countSearch
                                                              .toString())
                                                  .toString() +
                                              " " +
                                              "ManajemenRoleIndexHasilPencarian"
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
                                          text: "ManajemenRoleIndexTidakDitemukanHasilPencarian"
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
                  Expanded(child: _showlistRole()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showlistRole() {
    return Stack(children: [
      //KALAU MASIH LOADING
      Obx(() => controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA
          (controller.listRole.length == 0 &&
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
                        'InfoPraTenderIndexLabelSearchKeyword'.tr +
                            'InfoPraTenderIndexLabelSearchTidakDitemukan'.tr +
                            '\n' +
                            'InfoPraTenderIndexLabelDiSistem'
                                .tr, //Keyword tidak ditemukan disistem,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listRoleRefresher())
    ]);
  }

  Widget _listRoleRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listRole.length == controller.countSearch.value
            ? false
            : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 10;
          await controller.getListRole(
              controller.countData.value, controller.jenisTab.value);
        },
        onRefresh: () async {
          controller.listRole.clear();
          controller.isLoadingData.value = true;
          await controller.getListRole(1, controller.jenisTab.value);
        },
        child: _listRoleTile());
  }

  Widget _listRoleTile() {
    return ListView.builder(
      itemCount: controller.listRole.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //KALAU DIA ADA DATA, MUNCUL DISINI, JIKA TIDAK
              GestureDetector(
                onTap: () async {
                  controller.cekDetail =
                      await SharedPreferencesHelper.getHakAkses(
                          "Lihat Detail Role",
                          denganLoading: true);
                  if (SharedPreferencesHelper.cekAkses(controller.cekDetail)) {
                    var data =
                        await GetToPage.toNamed<DetailManajemenRoleController>(
                            Routes.DETAIL_MANAJEMEN_ROLE,
                            arguments: [controller.listRole[index]['id']]);

                    if (data != null) {
                      controller.refreshAll();
                    }
                  }
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
                      border: controller.listRole[index]['status'] == 0
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
                              color: controller.listRole[index]['status'] == 1
                                  // ? Color(ListColor.colorHeaderListTender)
                                  ? GlobalVariable.cardHeaderManajemenColor
                                  : Color(ListColor.colorBackgroundDisable),
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
                              SvgPicture.asset(
                                  GlobalVariable.imagePath + "user_admin.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                  child: Container(
                                child: Wrap(children: [
                                  CustomText(
                                    controller.listRole[index]['nama'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ]),
                              )),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              Obx(() => GestureDetector(
                                  onTap: () async {
                                    controller.cekAktifNon =
                                        await SharedPreferencesHelper
                                            .getHakAkses(
                                                "Aktif/Nonaktifkan Role",
                                                denganLoading: true);
                                    if (SharedPreferencesHelper.cekAkses(
                                        controller.cekAktifNon)) {
                                      controller.aktifNonRole(
                                          controller.listRole[index]['id'],
                                          controller.listRole[index]['nama'],
                                          index,
                                          (controller.listRole[index]
                                                      ['status'] ==
                                                  1
                                              ? false
                                              : true));
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                        controller.listRole[index]['status'] ==
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
                            color: controller.listRole[index]['status'] == 1
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "notepad.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16)),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            controller.listRole[index]
                                                ['pekerjaan'],
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            wrapSpace: true,
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
                                          12,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "menu_list.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16)),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: CustomText(
                                            controller.listRole[index]['menu'],
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            wrapSpace: true,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "menu_list_delete.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16)),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: CustomText(
                                            GlobalVariable.formatMuatan(
                                                controller.listRole[index]
                                                    ['listkerja']),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            wrapSpace: true,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          2),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "check_list.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16)),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            controller.listRole[index]
                                                ['listakses'],
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            wrapSpace: true,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
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
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    7.5,
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                color: controller.listRole[index]['status'] == 1
                                    ? Colors.white
                                    : Color(
                                        ListColor.colorBackgroundDisableTile),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    bottomRight:
                                        Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
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
                                  color: Colors.white,
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        controller.cekHapus =
                                            await SharedPreferencesHelper
                                                .getHakAkses("Hapus Role",
                                                    denganLoading: true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekHapus)) {
                                          controller.hapusRole(
                                              controller.listRole[index]['id'],
                                              controller.listRole[index]
                                                  ['nama'],
                                              index,
                                              controller.listRole[index]
                                                  ['hapus']);
                                        }
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
                                              border: Border.all(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1.5,
                                                  color: controller.cekHapus
                                                      ? controller.listRole[
                                                              index]['hapus']
                                                          ? Color(
                                                              ListColor.colorRed)
                                                          : Color(ListColor.colorStroke)
                                                      : Color(ListColor.colorAksesDisable)),
                                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ManajemenRoleIndexHapus'
                                                    .tr, //Hapus
                                                fontSize: 12,
                                                color: controller.cekHapus
                                                    ? controller.listRole[index]
                                                            ['hapus']
                                                        ? Color(
                                                            ListColor.colorRed)
                                                        : Color(ListColor
                                                            .colorStroke)
                                                    : Color(ListColor
                                                        .colorAksesDisable),
                                                fontWeight: FontWeight.w600),
                                          ))),
                                ),
                                SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: Colors.white,
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        controller.cekTambah =
                                            await SharedPreferencesHelper
                                                .getHakAkses("Tambah Role",
                                                    denganLoading: true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekTambah)) {
                                          var data = await GetToPage.toNamed<
                                                  EditManajemenRoleController>(
                                              Routes.EDIT_MANAJEMEN_ROLE,
                                              arguments: [
                                                controller.listRole[index]
                                                    ['id'],
                                                'UBAH'
                                              ]);

                                          if (data != null) {
                                            controller.refreshAll();
                                          }
                                        }
                                      },
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
                                              border: Border.all(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1.5,
                                                  color: controller.cekTambah
                                                      ? Color(ListColor.colorBlue)
                                                      : Color(ListColor.colorAksesDisable)),
                                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ManajemenRoleIndexEdit'
                                                    .tr, //Edit
                                                fontSize: 12,
                                                color: controller.cekTambah
                                                    ? Color(ListColor.colorBlue)
                                                    : Color(ListColor
                                                        .colorAksesDisable),
                                                fontWeight: FontWeight.w600),
                                          ))),
                                ),
                                SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: controller.cekDetail
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorAksesDisable),
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        controller.cekDetail =
                                            await SharedPreferencesHelper
                                                .getHakAkses(
                                                    "Lihat Detail Role",
                                                    denganLoading: true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekDetail)) {
                                          var data = await GetToPage.toNamed<
                                                  DetailManajemenRoleController>(
                                              Routes.DETAIL_MANAJEMEN_ROLE,
                                              arguments: [
                                                controller.listRole[index]['id']
                                              ]);

                                          if (data != null) {
                                            controller.refreshAll();
                                          }
                                        }
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
                                                'ManajemenRoleIndexDetail'
                                                    .tr, //Detail
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
            ]);
      },
    );
  }

  Future<bool> willpop() async {
    print(controller.mapSort);
    Get.back(result: [
      controller.sortBy.value,
      controller.sortType.value,
      controller.mapSort,
      controller.sort
    ]);
  }
}
