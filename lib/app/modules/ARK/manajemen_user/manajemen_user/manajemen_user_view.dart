import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:math' as math;

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/global_variable.dart' as gv;
import 'manajemen_user_controller.dart';

class ManajemenUserView extends GetView<ManajemenUserController> {
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
          child: WillPopScope(
            onWillPop: onWillPop,
            child: SafeArea(
              child: Obx(
                () => Stack(children: [
                  Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          GlobalVariable.ratioWidth(Get.context) * 125), //108
                      child: Column(
                        children: [
                          //search bar
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 56,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        GlobalVariable.urlImageNavbar),
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
                                                        controller.onSave();
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
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              Expanded(
                                                child: Stack(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  children: [
                                                    Obx(() => CustomTextField(
                                                        context: Get.context,
                                                        textInputAction:
                                                            TextInputAction
                                                                .search,
                                                        readOnly: true,
                                                        onTap: (controller
                                                                        .listUser
                                                                        .length !=
                                                                    0 ||
                                                                controller
                                                                    .isFilter)
                                                            ? () {
                                                                controller
                                                                    .goToSearchPage();
                                                              }
                                                            : null,
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
                                                              "ManajemenUserIndexCariSubUser"
                                                                  .tr, //Cari Sub User
                                                          fillColor:
                                                              Colors.white,
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
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                32,
                                                            right: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                30,
                                                            top: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                9,
                                                            bottom: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                6,
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    ListColor
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
                                                                color: Color(
                                                                    ListColor
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
                                                    Obx(() => Container(
                                                          margin: EdgeInsets.only(
                                                              left: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  6,
                                                              right: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  2),
                                                          child:
                                                              SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                "ic_search_blue.svg",
                                                            color: controller
                                                                            .listUser
                                                                            .length ==
                                                                        0 &&
                                                                    !controller
                                                                        .isFilter
                                                                ? Color(ListColor
                                                                    .colorLightGrey2)
                                                                : null,
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                24,
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                24,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  controller.cekAssign =
                                                      await SharedPreferencesHelper
                                                          .getHakAkses(
                                                              "Assign Sub User",denganLoading:true);
                                                  if (SharedPreferencesHelper
                                                      .cekAkses(controller
                                                          .cekAssign)) {
                                                    showDialog(
                                                        context: Get.context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return WillPopScope(
                                                              onWillPop: () {},
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator()));
                                                        });
                                                    await controller
                                                        .getDropdownPeranSubUser();
                                                    Get.back();
                                                    if (controller
                                                            .listUser.length !=
                                                        0) {
                                                      var check = true;
                                                      if (!controller
                                                          .isSubscribed) {
                                                        popUpSubscribe();
                                                        check = false;
                                                      }
                                                      // if (!controller
                                                      //         .hasSubUserRole
                                                      //         .value &&
                                                      //     check) {
                                                      //   popUpCreateRole();
                                                      //   check = false;
                                                      // }
                                                      if (!controller
                                                              .hasSubUserActive
                                                              .value &&
                                                          check) {
                                                        popUpNoUserActive();
                                                        check = false;
                                                      }
                                                      if (check) {
                                                        controller
                                                            .showModalBagiPeranSubUser();
                                                      }
                                                    }
                                                  }
                                                },
                                                child: Obx(
                                                  () =>
                                                      (controller.listUser
                                                                      .length !=
                                                                  0 &&
                                                              controller
                                                                  .cekAssign
                                                          ? SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "Icon Blue Disable.svg",
                                                              color: GlobalVariable
                                                                  .tabDetailAcessoriesMainColor,
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            )
                                                          : SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "Icon Blue Disable.svg",
                                                              color: GlobalVariable
                                                                  .tabDetailAcessoriesDisableColor,
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            )),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (controller
                                                          .listUser.length !=
                                                      0)
                                                    controller
                                                        .showSortingDialog();
                                                },
                                                child: Obx(
                                                  () => (controller.listUser.length !=
                                                          0
                                                      ? ((controller.sortByUser.value != "")
                                                          ? SvgPicture.asset(
                                                              GlobalVariable.imagePath +
                                                                  "ic_sort_black_on.svg",
                                                              width: GlobalVariable.ratioWidth(Get.context) *
                                                                  24,
                                                              height:
                                                                  GlobalVariable.ratioWidth(Get.context) *
                                                                      24)
                                                          : SvgPicture.asset(
                                                              GlobalVariable.imagePath +
                                                                  "ic_sorting_blue.svg",
                                                              color: GlobalVariable.tabButtonMainColor,
                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                              height: GlobalVariable.ratioWidth(Get.context) * 24))
                                                      : SvgPicture.asset(
                                                          GlobalVariable
                                                                  .imagePath +
                                                              "sorting_disable.svg",
                                                          color: GlobalVariable
                                                              .tabDetailAcessoriesDisableColor,
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              24,
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              24,
                                                        )),
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
                            // height: GlobalVariable.ratioWidth(Get.context) * 64,
                            padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                              top: GlobalVariable.ratioWidth(Get.context) * 14,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 13,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
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
                                          if ((controller.listUser.length !=
                                                  0 ||
                                              controller.isFilter))
                                            controller.showFilter();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                2,
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    13,
                                          ),
                                          decoration: BoxDecoration(
                                              color: controller.isFilter
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
                                                  color: controller.isFilter
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
                                                  "ManajemenUserIndexFilter"
                                                      .tr, //Filter
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: controller.isFilter
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : (controller.listUser
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
                                                ((controller.listUser.length ==
                                                            0 &&
                                                        !controller.isFilter))
                                                    ? GlobalVariable.imagePath +
                                                        "filter_disable.svg"
                                                    : GlobalVariable.imagePath +
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
                                Expanded(child: SizedBox()),
                                !controller.isLoadingData.value
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        "lihat tutotrial.svg",
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                    color: Color(
                                                        ListColor.color4)),
                                                SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3),
                                                CustomText(
                                                    "ManajemenUserIndexLihatTutorialSubUser"
                                                        .tr, //Lihat Tutorial Role
                                                    fontSize: 12,
                                                    color:
                                                        Color(ListColor.color4),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4),
                                            !controller.isLoadingData.value
                                                ? CustomText(
                                                    'ManajemenUserIndexTotalUser'
                                                            .tr + //Total User
                                                        " ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataUser.value.toString()).toString()}"
                                                            .tr,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600)
                                                : SizedBox()
                                          ],
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    backgroundColor: Color(ListColor.colorBackgroundManajemen),
                    // backgroundColor: Color(ListColor.colorLightGrey6),
                    body: _showlistUser(),
                    bottomNavigationBar: BottomAppBarMuat(
                      centerItemText: '',
                      color: Colors.grey,
                      backgroundColor: Colors.white,
                      selectedColor: Color(ListColor.colorSelectedBottomMenu),
                      notchedShape: CircularNotchedRectangle(),
                      height: GlobalVariable.ratioWidth(Get.context) * 55,
                      onTabSelected: (index) async {
                        switch (index) {
                          case 0:
                            {
                              // Get.toNamed(Routes.INBOX);
                              await Chat.init(GlobalVariable.docID, gv.GlobalVariable.fcmToken);
                              Chat.toInbox();
                              break;
                            }
                          case 1:
                            {
                              Get.toNamed(Routes.PROFIL);
                              break;
                            }
                        }
                      },
                      items: [
                        BottomAppBarItemModel(
                            iconName: 'message_menu_icon.svg', text: ''),
                        BottomAppBarItemModel(
                            iconName: 'user_menu_icon.svg', text: ''),
                      ],
                      iconSize: 40,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: Container(
                      width: GlobalVariable.ratioWidth(context) * 62,
                      height: GlobalVariable.ratioWidth(context) * 62,
                      decoration: BoxDecoration(),
                      child: FloatingActionButton(
                        backgroundColor: controller.cekTambah
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorAksesDisable),
                        onPressed: () async {
                          controller.cekTambah =
                              await SharedPreferencesHelper.getHakAkses(
                                  "Tambah Sub User",denganLoading:true);
                          if (SharedPreferencesHelper.cekAkses(
                              controller.cekTambah)) {
                            var data = await GetToPage.toNamed<
                                    CreateManajemenUserController>(
                                Routes.CREATE_MANAJEMEN_USER,
                                arguments: [
                                  false, //isEdit
                                  {}, //dataUser
                                ]);

                            if (data != null) {
                              controller.reset();
                            }
                          }
                        },
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: GlobalVariable.ratioWidth(context) * 35,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 90.0)),
                            side: BorderSide(color: Colors.white, width: 4.0)),
                      ),
                    ),
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
          (controller.listUser.length == 0 &&
                  !controller.isLoadingData.value &&
                  controller.isFilter)
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
              (controller.listUser.length == 0 &&
                      !controller.isLoadingData.value)
                  ? Center(
                      child: Container(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 83,
                            height: GlobalVariable.ratioWidth(Get.context) * 75,
                            child: Image.asset(GlobalVariable.imagePath +
                                "tidak_ada_data.png")),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 15),
                        CustomText(
                            'ManajemenUserIndexBelumAdaSubUser'
                                .tr, // Belum Ada Role
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listUserRefresher()
    ]);
  }

  Widget _listUserRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listUser.length == controller.jumlahDataUser.value
                ? false
                : true,
        controller: controller.refreshUserController,
        onLoading: () async {
          controller.countDataUser.value += 10;
          await controller.getListUser(
              controller.countDataUser.value, controller.filter);
        },
        onRefresh: () async {
          controller.countDataUser.value = 1;
          controller.listUser.clear();
          controller.isLoadingData.value = true;
          await controller.getListUser(1, controller.filter);
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
                  onTap: () async {
                    // var data =
                    //     await GetToPage.toNamed<DetailManajemenUserController>(
                    //         Routes.DETAIL_MANAJEMEN_ROLE,
                    //         arguments: [controller.listUser[index]['id']]);

                    // if (data != null) {
                    //   controller.refreshAll();
                    // }
                  },
                  child: cardTile(content, index)),
              index == controller.listUser.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
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
                      ? GlobalVariable.cardHeaderManajemenColor
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
                  vertical: GlobalVariable.ratioWidth(Get.context) * 17,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          await SharedPreferencesHelper
                                              .getHakAkses(
                                                  "Aktif/Nonaktifkan Sub User",denganLoading:true);
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
                                              ? (controller.cekAktifNon
                                                  ? GlobalVariable.imagePath +
                                                      "Toggle on.svg"
                                                  : GlobalVariable.imagePath +
                                                      "Toggle disabled.svg")
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
                                  controller.cekTambah =
                                      await SharedPreferencesHelper.getHakAkses(
                                          "Tambah Sub User",denganLoading:true);
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
                                    color: controller.cekTambah
                                        ? controller.listUser[index]
                                                    ['remaining_diff'] !=
                                                0
                                            ? Color(ListColor.colorLightGrey2)
                                            : Color(ListColor.colorBlue)
                                        : Color(ListColor.colorAksesDisable),
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

  void popUpSubscribe() async {
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
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "ManajemenUserIndexBagiPeranSubUser"
                                              .tr,
                                          fontSize: 16,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      CustomText(
                                          "ManajemenUserIndexAndaBelumDapatMembagiPeran"
                                              .tr,
                                          fontSize: 14,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
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
                                    'assets/ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }

  void popUpCreateRole() async {
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
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "ManajemenUserIndexAndaBelumMemilikiRoleHakAkses"
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
                                          Get.back();
                                          GetToPage.toNamed<
                                                  ManajemenRoleController>(
                                              Routes.MANAJEMEN_ROLE);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Color(ListColor.colorBlue),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      9),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CustomText(
                                                    "ManajemenUserIndexBukaManajemenRole"
                                                        .tr,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ]),
                                        ),
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
                                    'assets/ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }

  void popUpNoUserActive() async {
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
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "ManajemenUserIndexAndaBelumMemilikiSubUser"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
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
                                    'assets/ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }
}
