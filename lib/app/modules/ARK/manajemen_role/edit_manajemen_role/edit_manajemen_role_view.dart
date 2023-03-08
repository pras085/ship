import 'dart:async';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_bottom_demo.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:validators/validators.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:open_file/open_file.dart';

import 'edit_manajemen_role_controller.dart';

class EditManajemenRoleView extends GetView<EditManajemenRoleController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          controller.onSetData('COMPARE');
        },
        child: SafeArea(
            child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      GlobalVariable.ratioWidth(Get.context) * 56),
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
                            color: Color(ListColor.colorLightGrey)
                                .withOpacity(0.5),
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
                                  controller.onSetData('COMPARE');
                                },
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "ic_back_button.svg",
                                    color: GlobalVariable
                                        .tabDetailAcessoriesMainColor,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24))),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Container(
                          child: CustomText(
                            "ManajemenRoleEditRoleEditRole".tr, //Edit Role
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
                      Expanded(child: CustomText("")),
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
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20))),
                              color: Color(ListColor.color4),
                              onPressed: !controller.isLoading.value
                                  ? () {
                                      FocusScope.of(Get.context).unfocus();
                                      controller.onSave();
                                    }
                                  : null,
                              child: CustomText(
                                "ManajemenRoleTambahRoleSelanjutnya"
                                    .tr, // Selanjutnya
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )))),
                    ])),
                body: Obx(() => !controller.isLoading.value
                    ? SafeArea(
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            child: SingleChildScrollView(
                                child: Form(
                              key: controller.form,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                ),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          "ManajemenRoleTambahRoleRole".tr +
                                              "*", // Role
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(ListColor.colorGrey3)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8),
                                      CustomTextFormField(
                                          context: Get.context,
                                          newContentPadding:
                                              EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                          ),
                                          textSize: 14,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          newInputDecoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            prefix: SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        13),
                                            suffix: SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        13),
                                            isDense: true,
                                            isCollapsed: true,
                                            hintText:
                                                "ManajemenRoleTambahRoleIsiRole"
                                                    .tr, //Isi Role
                                            hintStyle: TextStyle(
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          controller:
                                              controller.namaController.value,
                                          validator: (value) {
                                            if (value.isEmpty || value == "") {
                                              return "ManajemenRoleTambahRoleAndaBelumMengisiNamaRole"
                                                  .tr; // Anda belum mengisi nama role
                                            } else if (controller
                                                    .errorNama.value !=
                                                "") {
                                              return controller.errorNama.value
                                                  .tr; // Nama Role telah digunakan
                                            }
                                            return null;
                                          }),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                      CustomText(
                                          "ManajemenRoleTambahRoleDeskripsiRole"
                                                  .tr +
                                              "*", // Deskripsi Role
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(ListColor.colorGrey3)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8),
                                      CustomTextFormField(
                                          context: Get.context,
                                          maxLines: 4,
                                          newContentPadding:
                                              EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                          ),
                                          textSize: 14,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          newInputDecoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            prefix: SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        13),
                                            suffix: SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        13),
                                            isDense: true,
                                            isCollapsed: true,
                                            hintText:
                                                "ManajemenRoleTambahRoleIsiDeskripsiRole"
                                                    .tr, //Isi Deskripsi Role
                                            hintStyle: TextStyle(
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          controller: controller
                                              .deskripsiController.value,
                                          validator: (value) {
                                            if (value.isEmpty || value == "") {
                                              return "ManajemenRoleTambahRoleAndaBelumMengisiDeskripsi"
                                                  .tr; // Anda belum mengisi deskripsi role
                                            }
                                            return null;
                                          }),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                      CustomText(
                                          "ManajemenRoleTambahRoleMenu".tr +
                                              "*", // Menu
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(ListColor.colorGrey3)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8),
                                      Obx(() => DropdownBelow(
                                            itemWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    32,
                                            itemTextstyle: TextStyle(
                                                color:
                                                    Color(ListColor.colorGrey3),
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            boxTextstyle: TextStyle(
                                                color: Color(
                                                    ListColor.colorLightGrey4),
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            boxPadding: EdgeInsets.only(
                                                left: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    12,
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                            boxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    32,
                                            boxHeight:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    44,
                                            boxDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        6),
                                                border: Border.all(
                                                    width: 1,
                                                    color: controller.errorMenu
                                                                .value !=
                                                            ""
                                                        ? Color(
                                                            ListColor.colorRed)
                                                        : Color(ListColor
                                                            .colorGrey2))),
                                            icon: Icon(
                                                Icons.keyboard_arrow_down_sharp,
                                                size: 30,
                                                color: Color(
                                                    ListColor.colorGrey4)),
                                            hint: CustomText(
                                                controller.indexMenu.value == -1
                                                    ? "ManajemenRoleTambahRolePilihMenu"
                                                        .tr //Pilih Menu
                                                    : controller.listMenu[
                                                        controller.indexMenu
                                                            .value]['nama'],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: controller
                                                            .indexMenu.value ==
                                                        -1
                                                    ? Color(
                                                        ListColor.colorGrey3)
                                                    : Colors.black),
                                            value: controller.indexMenu.value ==
                                                    -1
                                                ? null
                                                : controller.indexMenu.value,
                                            items: [
                                              for (var x = 0;
                                                  x <
                                                      controller
                                                          .listMenu.length;
                                                  x++)
                                                DropdownMenuItem(
                                                  child: CustomText(
                                                      controller.listMenu[x]
                                                          ['nama'],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Color(ListColor
                                                          .colorLabelBelumDitentukanPemenang)),
                                                  value: x,
                                                ),
                                            ],
                                            onChanged: (value) {
                                              FocusManager.instance.primaryFocus
                                                  .unfocus();
                                              if (controller.indexMenu.value !=
                                                  value) {
                                                controller.idListHakAkses
                                                    .clear();
                                              }
                                              controller.indexMenu.value =
                                                  value;
                                              print(controller.listMenu[
                                                      controller.indexMenu
                                                          .value]['id']
                                                  .toString());
                                              controller.idmenu =
                                                  controller.listMenu[controller
                                                      .indexMenu.value]['id'];
                                            },
                                          )),
                                      controller.errorMenu.value != ""
                                          ? Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Obx(
                                                            () => CustomText(
                                                                  controller
                                                                      .errorMenu
                                                                      .value
                                                                      .tr,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  height: 1.2,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorRed),
                                                                ))),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            74)
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ))))
                    : Center(child: CircularProgressIndicator())))));
  }
}
