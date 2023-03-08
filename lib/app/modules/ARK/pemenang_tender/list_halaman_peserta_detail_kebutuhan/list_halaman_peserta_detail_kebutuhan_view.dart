import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_halaman_peserta_detail_kebutuhan_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListHalamanPesertaDetailKebutuhanView
    extends GetView<ListHalamanPesertaDetailKebutuhanController> {
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
                                        "ProsesTenderLihatPesertaLabelDetailKebutuhan"
                                            .tr, //Detail Kebutuhan
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.00,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    body: Obx(() => Container(
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
                                      index < controller.dataRuteTender.length;
                                      index++)
                                    controller.satuanTender == 2
                                        ? controller
                                            .unitTrukRuteDitenderkanWidget(
                                                index)
                                        : controller.satuanTender == 1
                                            ? controller
                                                .beratRuteDitenderkanWidget(
                                                    index)
                                            : controller.satuanTender == 3
                                                ? controller
                                                    .volumeRuteDitenderkanWidget(
                                                        index)
                                                : SizedBox()
                                ])))))))));
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
