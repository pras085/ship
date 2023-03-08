import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/create_manajemen_role/create_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/detail_manajemen_role/detail_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/edit_manajemen_role/edit_manajemen_role_controller.dart';
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
import 'manajemen_role_controller.dart';

class ManajemenRoleView extends GetView<ManajemenRoleController> {
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
                        GlobalVariable.ratioWidth(Get.context) * 125), //108
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
                                                      Get.back();
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
                                                      context: Get.context,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      readOnly: true,
                                                      onTap: (controller
                                                                      .listRole
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
                                                            "ManajemenRoleIndexCariRole"
                                                                .tr, //Cari Role
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
                                                        child: SvgPicture.asset(
                                                          GlobalVariable
                                                                  .imagePath +
                                                              "ic_search_blue.svg",
                                                          color: controller
                                                                          .listRole
                                                                          .length ==
                                                                      0 &&
                                                                  !controller
                                                                      .isFilter
                                                              ? Color(ListColor
                                                                  .colorLightGrey2)
                                                              : null,
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              24,
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              24,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  if (controller
                                                          .listRole.length !=
                                                      0)
                                                    controller
                                                        .showSortingDialog();
                                                },
                                                child: Obx(() => (controller.listRole.length != 0
                                                    ? ((controller.sortByRole.value != "")
                                                        ? SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                "ic_sort_black_on.svg",
                                                            width: GlobalVariable.ratioWidth(Get.context) *
                                                                24,
                                                            height:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    24)
                                                        : SvgPicture.asset(
                                                            GlobalVariable.imagePath + "ic_sorting_blue.svg",
                                                            color: GlobalVariable.tabButtonMainColor,
                                                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                            height: GlobalVariable.ratioWidth(Get.context) * 24))
                                                    : SvgPicture.asset(GlobalVariable.imagePath + "sorting_disable.svg", color: GlobalVariable.tabDetailAcessoriesDisableColor, width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24))))
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
                          //height: GlobalVariable.ratioWidth(Get.context) * 64,
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16,
                            top: GlobalVariable.ratioWidth(Get.context) * 14,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 13,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                        if ((controller.listRole.length != 0 ||
                                            controller.isFilter))
                                          controller.showFilter();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2,
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              13,
                                        ),
                                        decoration: BoxDecoration(
                                            color: controller.isFilter
                                                ? Color(ListColor
                                                    .colorBackgroundFilterTender)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20),
                                            border: Border.all(
                                                width: 1,
                                                color: controller.isFilter
                                                    ? Color(ListColor.colorBlue)
                                                    : Color(ListColor
                                                        .colorLightGrey7))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                "ManajemenRoleIndexFilter"
                                                    .tr, //Filter
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: controller.isFilter
                                                    ? Color(ListColor.colorBlue)
                                                    : (controller.listRole
                                                                .length ==
                                                            0)
                                                        ? Color(ListColor
                                                            .colorLightGrey2)
                                                        : Color(ListColor
                                                            .colorDarkBlue2)),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7,
                                            ),
                                            SvgPicture.asset(
                                              ((controller.listRole.length ==
                                                          0 &&
                                                      !controller.isFilter))
                                                  ? GlobalVariable.imagePath +
                                                      "filter_disable.svg"
                                                  : GlobalVariable.imagePath +
                                                      "filter_active.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
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
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "lihat tutotrial.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  color:
                                                      Color(ListColor.color4)),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3),
                                              CustomText(
                                                  "ManajemenRoleIndexLihatTutorialRole"
                                                      .tr, //Lihat Tutorial Role
                                                  fontSize: 12,
                                                  color:
                                                      Color(ListColor.color4),
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          (controller.listRole.length > 0 ||
                                                      controller.isFilter) &&
                                                  !controller
                                                      .isLoadingData.value
                                              ? CustomText(
                                                  'ManajemenRoleIndexTotalRole'
                                                          .tr + //Total Role
                                                      " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataRole.value.toString()).toString()}"
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
                  body: _showlistRole(),
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
                                "Tambah Role",
                                denganLoading: true);
                        if (SharedPreferencesHelper.cekAkses(
                            controller.cekTambah)) {
                          var data = await GetToPage.toNamed<
                                  CreateManajemenRoleController>(
                              Routes.CREATE_MANAJEMEN_ROLE);

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
        ));
  }

  Widget _showlistRole() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeRole
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listRole.length == 0 &&
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
                        'ManajemenRoleIndexDataTidakDitemukan'
                                .tr + //Data Tidak Ditemukan
                            '\n' +
                            'ManajemenRoleIndexMohonCoba'
                                .tr, //Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ManajemenRoleIndexAtau'.tr, //Atau
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
                                        'ManajemenRoleIndexAturUlangFilter'
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
              (controller.listRole.length == 0 &&
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
                            'ManajemenRoleIndexBelumAdaRole'
                                .tr, // Belum Ada Role
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listRoleRefresher()
    ]);
  }

  Widget _listRoleRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listRole.length == controller.jumlahDataRole.value
                ? false
                : true,
        controller: controller.refreshRoleController,
        onLoading: () async {
          controller.countDataRole.value += 10;
          await controller.getListRole(
              controller.countDataRole.value, controller.filter);
        },
        onRefresh: () async {
          controller.countDataRole.value = 1;
          controller.listRole.clear();
          controller.isLoadingData.value = true;
          await controller.getListRole(1, controller.filter);
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
              ),
              index == controller.listRole.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
            ]);
      },
    );
  }
}
