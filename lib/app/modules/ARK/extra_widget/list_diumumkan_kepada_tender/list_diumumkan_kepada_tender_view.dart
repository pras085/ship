import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_diumumkan_kepada_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListDiumumkanKepadaTenderView
    extends GetView<ListDiumumkanKepadaTenderController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
            child: SafeArea(
                child: Scaffold(
                    backgroundColor: Color(ListColor.colorLightGrey6),
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          GlobalVariable.ratioWidth(Get.context) * 56),
                      child: Container(
                        alignment: Alignment.center,
                        height: GlobalVariable.ratioWidth(Get.context) * 56,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 12),
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(ListColor.colorLightGrey)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ], color: Colors.white),
                        child: Stack(
                          children: [
                            Positioned(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        onWillPop();
                                      },
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              "ic_back_blue_button.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24))),
                            )),
                            Positioned(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: CustomText(
                                        "InfoPraTenderCreateLabelDiumumkanKepada"
                                            .tr, //Data Rute
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.00,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: controller.mode ==
                                "DETAIL_INFO_PRA_TENDER" ||
                            controller.mode == "DETAIL_PROSES_TENDER" ||
                            controller.mode ==
                                "EDIT_INFO_PRA_TENDER_SEKARANG" ||
                            controller.mode == "EDIT_PROSES_TENDER_SEKARANG"
                        ? null
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                  topRight: Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(0, -5),
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 11,
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        96),
                            child: MaterialButton(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20))),
                              color: Color(ListColor.color4),
                              onPressed: () {
                                controller.onSave();
                              },
                              child: CustomText(
                                "InfoPraTenderCreateLabelButtonTerapkan"
                                    .tr, //Terapkan
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                    body: Obx(() => Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: Form(
                            key: controller.form,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                  ),
                                  controller.expandedWidget(
                                      'InfoPraTenderCreateLabelMitra'
                                          .tr, // Mitra
                                      controller.dataMitraTransporter
                                          .where((element) =>
                                              element['ismitra'] == 1 &&
                                              element['select'] == true)
                                          .toList()),
                                  controller.expandedWidget(
                                      'InfoPraTenderCreateLabelTransporter'
                                          .tr, // Transporter
                                      controller.dataMitraTransporter
                                          .where((element) =>
                                              element['ismitra'] == 0 &&
                                              element['select'] == true)
                                          .toList()),
                                  controller.expandedWidget(
                                      'InfoPraTenderCreateLabelGroup'
                                          .tr, // Group
                                      controller.dataGroup
                                          .where((element) =>
                                              element['select'] == true)
                                          .toList()),
                                  controller.mode != "DETAIL_INFO_PRA_TENDER" &&
                                          controller.mode !=
                                              "DETAIL_PROSES_TENDER"
                                      ? controller.expandedWidget(
                                          'InfoPraTenderCreateLabelInvitedTransporter'
                                              .tr, // Invited Transporter
                                          controller.dataEmail)
                                      : SizedBox(),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          48)
                                ])))))))));
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
