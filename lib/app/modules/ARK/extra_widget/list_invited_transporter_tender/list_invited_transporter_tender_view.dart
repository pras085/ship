import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_invited_transporter_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListInvitedTransporterTenderView
    extends GetView<ListInvitedTransporterTenderController> {
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
                                          "InfoPraTenderDetailLabelInvitedTransporter"
                                              .tr, //Data Rute
                                          height: 1.2,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.00,
                                          color:
                                              Color(ListColor.colorDarkGrey3)),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
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
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 96),
                      child: MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20))),
                        color: Color(ListColor.color4),
                        onPressed: () {
                          controller.validasiSimpan =
                              controller.form.currentState.validate();

                          if (controller.validasiSimpan) {
                            controller.onSave();
                          }
                        },
                        child: CustomText(
                          "InfoPraTenderDetailLabelKirim".tr, // Kirim
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
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20),
                                  for (var index = 0;
                                      index < controller.emailController.length;
                                      index++)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            'InfoPraTenderDetailLabelEmail'
                                                .tr, // Email
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Color(ListColor.colorGrey3)),
                                        SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: CustomTextFormField(
                                              context: Get.context,
                                              newContentPadding:
                                                  EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8,
                                                bottom:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                                //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                              ),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(ListColor
                                                      .colorLightGrey4)),
                                              textSize: 12,
                                              newInputDecoration:
                                                  InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                prefix: SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                suffix: SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        11),
                                                isDense: true,
                                                isCollapsed: true,
                                                hintText:
                                                    "InfoPraTenderDetailLabelEmailTransporterDiundang"
                                                        .tr, //Email Transporter yang ingin diundang
                                                hintStyle: TextStyle(
                                                    color: Color(ListColor
                                                        .colorLightGrey2),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              controller: controller
                                                  .emailController[index],
                                              onEditingComplete: () {
                                                controller.form.currentState
                                                    .validate();
                                              },
                                              validator: (value) {
                                                var error = "";
                                                error = controller
                                                    .cekFormatEmail(value);

                                                if (error == "") {
                                                  error = controller
                                                      .cekEmailKembar(index);
                                                }

                                                if (error == "") {
                                                  return null;
                                                } else {
                                                  return error;
                                                }
                                              },
                                            )),
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            controller.emailController.length >
                                                    1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .hapusEmail(index);
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            32,
                                                        child: SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                'minus_square.svg',
                                                            width:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    32)))
                                                : SizedBox(
                                                    width:
                                                        GlobalVariable.ratioWidth(Get.context) * 32),
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            index ==
                                                    controller.emailController
                                                            .length -
                                                        1
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.tambahEmail();
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            32,
                                                        child: SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                'plus_square.svg',
                                                            width: GlobalVariable.ratioWidth(
                                                                    Get.context) *
                                                                32)))
                                                : SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
                                          ],
                                        ),
                                        SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14),
                                      ],
                                    ),
                                ])))))))));
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
