import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/create_manajemen_role/create_manajemen_role_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'dart:math' as math;

import 'manajemen_user_bagi_peran_controller.dart';

class ManajemenUserBagiPeranView
    extends GetView<ManajemenUserBagiPeranController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Container(
            alignment: Alignment.center,
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(GlobalVariable.urlImageNavbar),
                    fit: BoxFit.fill),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: GestureDetector(
                        onTap: () {
                          onWillPop();
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color: GlobalVariable.tabDetailAcessoriesMainColor,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24))),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                Container(
                  child: CustomText(
                    "ManajemenUserBagiPeranPenugasanSubUser"
                        .tr, //Penugasan Sub User
                    fontWeight: FontWeight.w700,
                    fontSize: 16.00,
                    // color: Color(ListColor.colorWhite),
                    color: GlobalVariable.tabDetailAcessoriesMainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 23,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 23,
              GlobalVariable.ratioWidth(Get.context) * 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10),
                  topRight: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: !controller.isChanged.value
                            ? Color(ListColor.colorLightGrey2)
                            : Color(ListColor.color4),
                        side: BorderSide(
                            width: 1,
                            color: !controller.isChanged.value
                                ? Color(ListColor.colorLightGrey2)
                                : Color(ListColor.color4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 20)),
                        )),
                    onPressed: () {
                      if (controller.isChanged.value) {
                        controller.onSubmit();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 50,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                      child: Stack(alignment: Alignment.center, children: [
                        CustomText("ManajemenUserBagiPeranSimpan".tr,
                            fontWeight: FontWeight.w600,
                            color: !controller.isChanged.value
                                ? Color(ListColor.colorLightGrey4)
                                : Colors.white),
                      ]),
                    ),
                  )),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(Get.context).size.height,
          width: MediaQuery.of(Get.context).size.width,
          //KALAU MASIH LOADING
          child: Obx(
            () => controller.loading.value
                ? Center(
                    child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()),
                  )
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Obx(
                            () => Container(
                              height: controller.hasNextSubsciption.value
                                  ? GlobalVariable.ratioWidth(context) * 24
                                  : 0,
                            ),
                          ),
                          Obx(
                            () => controller.hasNextSubsciption.value
                                ? buttonBagiPeranSubUser()
                                : Container(),
                          ),
                          Container(
                            height: GlobalVariable.ratioWidth(context) * 24,
                          ),
                          //user & periode
                          cardUserPeriode(),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(context) * 24),
                            height: GlobalVariable.ratioWidth(context) * 1,
                            width: MediaQuery.of(context).size.width -
                                GlobalVariable.ratioWidth(context) * 32,
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorLightGrey21),
                            ),
                          ),
                          //search bar
                          searchBar(),
                          Container(
                            height: GlobalVariable.ratioWidth(context) * 24,
                          ),
                          for (int index = 0;
                              index < controller.listUser.length;
                              index++)
                            cardTile(context, index),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    ));
  }

  Future<bool> onWillPop() async {
    if (controller.isChanged.value) {
      popUpGetOut();
    } else {
      Get.back();
    }
  }

  Widget buttonBagiPeranSubUser() {
    return GestureDetector(
      onTap: () {
        controller.nextSubscription();
      },
      child: Container(
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 2),
                child: SvgPicture.asset(
                    GlobalVariable.imagePath + "Icon Blue Disable.svg",
                    color: Color(ListColor.colorBlue),
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                    height: GlobalVariable.ratioWidth(Get.context) * 16)),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 4),
            Container(
              child: CustomText(
                "ManajemenUserBagiPeranBagiPeranLanggananBerikutnya".tr,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: MediaQuery.of(Get.context).size.width -
          GlobalVariable.ratioWidth(Get.context) * 32,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomTextField(
              context: Get.context,
              textInputAction: TextInputAction.search,
              readOnly: true,
              onTap: () {
                controller.goToSearchPage();
              },
              textSize: 14,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              newInputDecoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                hintText: "ManajemenUserIndexCariSubUser".tr, //Cari Sub User
                fillColor: Colors.white,
                hintStyle: TextStyle(
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                contentPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 32,
                  right: GlobalVariable.ratioWidth(Get.context) * 30,
                  top: GlobalVariable.ratioWidth(Get.context) * 13,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.colorLightGrey7),
                      width: GlobalVariable.ratioWidth(Get.context) * 1),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.colorLightGrey7),
                      width: GlobalVariable.ratioWidth(Get.context) * 1),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 7),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(ListColor.color4),
                      width: GlobalVariable.ratioWidth(Get.context) * 1),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 7),
                ),
              )),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 6,
                right: GlobalVariable.ratioWidth(Get.context) * 2),
            child: SvgPicture.asset(
              GlobalVariable.imagePath + "ic_search_blue.svg",
              color: Color(ListColor.colorLightGrey2),
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardUserPeriode() {
    return Container(
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * 16,
            0, GlobalVariable.ratioWidth(Get.context) * 16, 0),
        // GlobalVariable.ratioWidth(Get.context) * 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
          border: Border.all(color: Color(ListColor.colorHeaderListTender)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // header
            Container(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 13,
                  GlobalVariable.ratioWidth(Get.context) * 12),
              decoration: BoxDecoration(
                  color: GlobalVariable.cardHeaderManajemenColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10))),
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  // SvgPicture.asset(GlobalVariable.imagePath + "user_admin.svg",
                  //     width:
                  //         GlobalVariable.ratioWidth(Get.context) *
                  //             24,
                  //     height:
                  //         GlobalVariable.ratioWidth(Get.context) *
                  //             24),
                  // SizedBox(
                  //     width:
                  //         GlobalVariable.ratioWidth(Get.context) *
                  //             8),
                  Expanded(
                      child: Container(
                    child: Wrap(children: [
                      CustomText(
                        controller.title,
                        color: Color(ListColor.colorBlue),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
                  )),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //periode
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  // padding: EdgeInsets.only(
                                  // top: GlobalVariable.ratioWidth(
                                  //         Get.context) *
                                  //     2),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + "Calendar.svg",
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
                                    "ManajemenUserBagiPeranPeriode".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.ubahPeriode();
                                },
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranUbahPeriode".tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorBlue),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        //periode awal
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranPeriodeAwal".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  child: CustomText(
                                    controller.selectedPeriode['FullStartDate'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        //periode akhir
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranPeriodeAkhir".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  child: CustomText(
                                    controller.selectedPeriode['FullEndDate'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 14,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  // padding: EdgeInsets.only(
                                  //     top: GlobalVariable.ratioWidth(
                                  //             Get.context) *
                                  //         2),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + "Sub User.svg",
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
                                    "ManajemenUserBagiPeranSubUser".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranJumlahUser".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              Container(
                                child: CustomText(
                                  controller.selectedPeriode["Quota"]
                                          .toString() +
                                      " " +
                                      "ManajemenUserBagiPeranSubUser".tr,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranSudahDitugaskan".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  child: CustomText(
                                    controller.usedUser.value.toString() +
                                        " " +
                                        "ManajemenUserBagiPeranSubUser".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              Expanded(
                                child: Container(
                                  child: CustomText(
                                    "ManajemenUserBagiPeranBelumDitugaskan".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Container(
                                  child: CustomText(
                                    (controller.selectedPeriode["Quota"] -
                                                controller.usedUser.value)
                                            .toString() +
                                        " " +
                                        "ManajemenUserBagiPeranSubUser".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
                  color: Color(ListColor.colorHeaderListTender),
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
                        if (controller.usedUser.value <
                                controller.selectedPeriode["Quota"] &&
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
                                        .tr //Pilih Role
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
                            ? Column(
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
                              )
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
          GetToPage.toNamed<ManajemenRoleController>(Routes.MANAJEMEN_ROLE);
          GetToPage.toNamed<CreateManajemenRoleController>(
              Routes.CREATE_MANAJEMEN_ROLE);
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void popUpGetOut() async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderCreateLabelInfoKonfirmasiPembatalan"
            .tr, //Konfirmasi Pembatalan
        message: "ProsesTenderCreateLabelInfoApakahAndaYakinInginKembali".tr +
            "\n" +
            "ProsesTenderCreateLabelInfoDataTidakDisimpan"
                .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          Get.back();
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }
}
