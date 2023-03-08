import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/search_location_address/search_location_address_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchLocationAddressView
    extends GetView<SearchLocationAddressController> {
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
                                        hintText: controller
                                            .hintText.value, // Cari User
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
                    // _listLastSearch()
                    controller.lastShow.value
                        ? _listLastSearch()
                        : _listLocation(),
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
                      "CariHargaTransportIndexPencarianTerakhir"
                          .tr, // Pencarian Terakhir
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  CustomText(""),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "lokasi gray.svg",
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color(ListColor.colorLightGrey4))),
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

  Widget _listLocation() {
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
                      "CariHargaTransportIndexHasilPencarian"
                          .tr, // Hasil Pencarian
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4)),
                  CustomText(""),
                ],
              )),
          Obx(() => !controller.isLoadingLast.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < controller.listSearchAddress.length;
                        index++)
                      GestureDetector(
                          onTap: () {
                            controller.chooseAddress(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 7,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "lokasi gray.svg",
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
                                        controller.listSearchAddress[index]
                                            ['title'],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color(ListColor.colorLightGrey4))),
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

  Future<bool> willpop() async {
    print(controller.mapSort);
    // controller.onSave();
    Get.back();
  }
}
