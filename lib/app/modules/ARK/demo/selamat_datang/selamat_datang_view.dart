import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/demo/selamat_datang/selamat_datang_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SelamatDatangView extends GetView<SelamatDatangController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: GlobalVariable.ratioWidth(Get.context) * 56,
          leadingWidth: GlobalVariable.ratioWidth(Get.context) * (24 + 16),
          leading: Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    GlobalVariable.imagePath + "ic_back_button.svg",
                  ))),
          title: Image.asset(
            GlobalVariable.imagePath + "white_logo_icon.png",
            height: GlobalVariable.ratioWidth(Get.context) * 24,
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  print('notifikasi');
                },
                child: SvgPicture.asset(
                  GlobalVariable.imagePath +
                      "icon bell-red.svg", // Jika tidak ada notifikasi, icon bell.svg
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                )),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 16,
            )
          ],
          centerTitle: true,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Color(ListColor.colorBlue),
            ),
          )),
      body: Obx(
        () => controller.loading == false
            ? SafeArea(
                child: Container(
                    child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(GlobalVariable.imagePath +
                                "hero.png"), //hero.png
                            fit: BoxFit.fill),
                      ),
                      padding: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 24,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 10,
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "DemoBigFleetsShipperIndexSelamatDatang"
                                    .tr, //Selamat datang di
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6),
                              controller.modul == 'BIGFLEET'
                                  ? CustomText(
                                      "Demo Big Fleets",
                                      color: Color(ListColor
                                          .colorIndicatorSelectedBigFleet2),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    )
                                  : CustomText(
                                      "Demo Transport Market",
                                      color: Color(ListColor
                                          .colorIndicatorSelectedBigFleet2),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                            ],
                          )),
                          controller.modul == 'BIGFLEET'
                              ? SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'selamat_datang_big_fleet.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          39,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          39)
                              : SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'selamat_datang_transport_market.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          39,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          39)
                        ],
                      )),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: AppBar(
                            toolbarHeight:
                                GlobalVariable.ratioWidth(Get.context) * 46,
                            elevation: 0.0,
                            centerTitle: true,
                            backgroundColor: Color(ListColor.colorBlue),
                            shadowColor: Colors.white,
                            foregroundColor: Colors.white,
                            automaticallyImplyLeading: false,
                            flexibleSpace: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                30.0),
                                        topRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                30.0))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Color(ListColor.colorStroke))),
                                  ),
                                  child: TabBar(
                                    // labelPadding: EdgeInsets.symmetric(
                                    //     vertical: GlobalVariable.ratioWidth(
                                    //             Get.context) *
                                    //         16),
                                    controller: controller.tabController,
                                    tabs: controller.sisi == 'TRANSPORTER'
                                        ? [
                                            Tab(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width *
                                                        50 /
                                                        100,
                                                    child: CustomText(
                                                      "Transporter",
                                                      color: controller.posTab
                                                                  .value ==
                                                              0
                                                          ? Color(ListColor
                                                              .colorBlue)
                                                          : Color(ListColor
                                                              .colorGrey3),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ))),
                                            Tab(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width *
                                                        50 /
                                                        100,
                                                    child: CustomText(
                                                      "Shipper",
                                                      color: controller.posTab
                                                                  .value ==
                                                              1
                                                          ? Color(ListColor
                                                              .colorBlue)
                                                          : Color(ListColor
                                                              .colorStroke),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    )))
                                          ]
                                        : [
                                            Tab(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width *
                                                        50 /
                                                        100,
                                                    child: CustomText(
                                                      "Shipper",
                                                      color: controller.posTab
                                                                  .value ==
                                                              0
                                                          ? Color(ListColor
                                                              .colorBlue)
                                                          : Color(ListColor
                                                              .colorGrey3),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ))),
                                            Tab(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width *
                                                        50 /
                                                        100,
                                                    child: CustomText(
                                                      "Transporter",
                                                      color: controller.posTab
                                                                  .value ==
                                                              1
                                                          ? Color(ListColor
                                                              .colorBlue)
                                                          : Color(ListColor
                                                              .colorGrey3),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    )))
                                          ],
                                  ),
                                ))),
                        backgroundColor: Colors.white,
                        body: Container(
                            color: Colors.white,
                            child: TabBarView(
                                controller: controller.tabController,
                                children: controller.sisi == 'TRANSPORTER'
                                    ? [
                                        controller.listTransporter(),
                                        controller.listShipper(),
                                      ]
                                    : [
                                        controller.listShipper(),
                                        controller.listTransporter(),
                                      ])),
                      ),
                    ),
                  )
                ],
              )))
            : Center(
                child: Container(
                    width: 30, height: 30, child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
