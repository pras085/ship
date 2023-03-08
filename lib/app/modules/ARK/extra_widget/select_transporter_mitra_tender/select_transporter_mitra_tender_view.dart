import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_transporter_mitra_tender/select_transporter_mitra_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_custom2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/strings.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SelectTransporterMitraTenderView
    extends GetView<SelectTransporterMitraTenderController> {
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
                      height: GlobalVariable.ratioWidth(Get.context) * 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              Color(ListColor.colorLightGrey).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 8),
                        ),
                      ], color: Colors.white),
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 12,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
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
                                SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Obx(() => CustomTextField(
                                          controller:
                                              controller.searchBar.value,
                                          context: Get.context,
                                          textInputAction:
                                              TextInputAction.search,
                                          onChanged: (value) {
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
                                            hintText:
                                                "InfoPraTenderCreateLabelCariMitraTransporterGroup" // Cari Mitra/Transporter/Group
                                                    .tr,
                                            fillColor: Colors.white,
                                            hintStyle: TextStyle(
                                              color: Color(
                                                  ListColor.colorLightGrey2),
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
                                                  color: Color(ListColor
                                                      .colorLightGrey7),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(ListColor
                                                      .colorLightGrey7),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Color(ListColor.color4),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                  .searchBar.value.text.isEmpty
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(right: 7),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .onClearSearch();
                                                      },
                                                      child: Icon(
                                                        Icons.close_rounded,
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                      )))))
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
                  // PreferredSize(
                  //   preferredSize: Size.fromHeight(
                  //       GlobalVariable.ratioWidth(Get.context) * 56),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: GlobalVariable.ratioWidth(Get.context) * 56,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal:
                  //             GlobalVariable.ratioWidth(Get.context) * 16,
                  //         vertical:
                  //             GlobalVariable.ratioWidth(Get.context) * 12),
                  //     decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  //       BoxShadow(
                  //         color:
                  //             Color(ListColor.colorLightGrey).withOpacity(0.5),
                  //         blurRadius: 10,
                  //         spreadRadius: 2,
                  //       ),
                  //     ], color: Colors.white),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Container(
                  //           child: ClipOval(
                  //             child: Material(
                  //                 shape: CircleBorder(),
                  //                 color: Color(ListColor.color4),
                  //                 child: InkWell(
                  //                     onTap: () {
                  //                       onWillPop();
                  //                     },
                  //                     child: Container(
                  //                         width: 30,
                  //                         height: 30,
                  //                         child: Center(
                  //                             child: Icon(
                  //                           Icons.arrow_back_ios_rounded,
                  //                           size: 24,
                  //                           color: Colors.white,
                  //                         ))))),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: GlobalVariable.ratioWidth(Get.context) * 12,
                  //         ),
                  //         Expanded(
                  //           child: Stack(
                  //             alignment: Alignment.centerLeft,
                  //             children: [
                  //               Obx(() => CustomTextField(
                  //                     controller: controller.searchBar.value,
                  //                     textInputAction: TextInputAction.search,
                  //                     context: Get.context,
                  //                     textSize: 14,
                  //                     newContentPadding: EdgeInsets.only(
                  //                         left: GlobalVariable.ratioWidth(
                  //                                 Get.context) *
                  //                             32,
                  //                         right: GlobalVariable.ratioWidth(
                  //                                 Get.context) *
                  //                             10,
                  //                         top: GlobalVariable.ratioWidth(
                  //                                 Get.context) *
                  //                             9,
                  //                         bottom: GlobalVariable.ratioWidth(
                  //                                 context) *
                  //                             6),
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                         color: Colors.black),
                  //                     // newContentPadding: EdgeInsets.symmetric(
                  //                     //     horizontal: 42,
                  //                     //     vertical:
                  //                     //         GlobalVariable.ratioWidth(context) * 6),
                  //                     newInputDecoration: InputDecoration(
                  //                       isDense: true,
                  //                       isCollapsed: true,
                  //                       hintText:
                  //                           "InfoPraTenderCreateLabelCariMitraTransporterGroup" // Cari Nama Mitra/Transporter/Group
                  //                               .tr,
                  //                       fillColor: Colors.white,
                  //                       filled: true,
                  //                       hintStyle: TextStyle(
                  //                           color: Color(ListColor.colorGrey5),
                  //                           fontSize:
                  //                               GlobalVariable.ratioWidth(
                  //                                       Get.context) *
                  //                                   14,
                  //                           fontWeight: FontWeight.w600),
                  //                       enabledBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide(
                  //                             color: Color(
                  //                                 ListColor.colorLightGrey7),
                  //                             width: 1.0),
                  //                         borderRadius: BorderRadius.circular(
                  //                             GlobalVariable.ratioWidth(
                  //                                     Get.context) *
                  //                                 10),
                  //                       ),
                  //                       border: OutlineInputBorder(
                  //                         borderSide: BorderSide(
                  //                             color: Color(
                  //                                 ListColor.colorLightGrey7),
                  //                             width: 1.0),
                  //                         borderRadius: BorderRadius.circular(
                  //                             GlobalVariable.ratioWidth(
                  //                                     Get.context) *
                  //                                 10),
                  //                       ),
                  //                       focusedBorder: OutlineInputBorder(
                  //                         borderSide: BorderSide(
                  //                             color: Color(
                  //                                 ListColor.colorLightGrey7),
                  //                             width: 1.0),
                  //                         borderRadius: BorderRadius.circular(
                  //                             GlobalVariable.ratioWidth(
                  //                                     Get.context) *
                  //                                 10),
                  //                       ),
                  //                     ),
                  //                     onChanged: (value) {
                  //                       controller.onSearch();
                  //                     },
                  //                   )),
                  //               Container(
                  //                 margin: EdgeInsets.only(
                  //                     left: GlobalVariable.ratioWidth(
                  //                             Get.context) *
                  //                         6,
                  //                     right: GlobalVariable.ratioWidth(
                  //                             Get.context) *
                  //                         2),
                  //                 child: SvgPicture.asset(
                  //                   GlobalVariable.imagePath+"ic_search_blue.svg",
                  //                   width:
                  //                       GlobalVariable.ratioWidth(Get.context) *
                  //                           24,
                  //                            height: GlobalVariable.ratioWidth(
                  //                               Get.context) *
                  //                           24,
                  //                 ),
                  //               ),
                  //               Align(
                  //                   alignment: Alignment.centerRight,
                  //                   child: Obx(() => controller
                  //                           .searchBar.value.text.isEmpty
                  //                       ? SizedBox.shrink()
                  //                       : Container(
                  //                           margin: EdgeInsets.only(right: 7),
                  //                           child: GestureDetector(
                  //                               onTap: () {
                  //                                 controller.onClearSearch();
                  //                               },
                  //                               child: Icon(
                  //                                 Icons.close_rounded,
                  //                                 size: GlobalVariable
                  //                                         .ratioWidth(
                  //                                             Get.context) *
                  //                                     24,
                  //                               )))))
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 11,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 22),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: MaterialButton(
                               padding: EdgeInsets.symmetric(
                                vertical:GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                  side: BorderSide(
                                    width:GlobalVariable.ratioWidth(Get.context) * 1,
                                      color: Color(ListColor.color4))),
                              onPressed: () {
                                controller.onReset();
                              },
                              child: CustomText(
                                "InfoPraTenderCreateLabelButtonReset"
                                    .tr, //Reset
                                color: Color(ListColor.color4),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            )),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        Expanded(
                            flex: 1,
                            child: MaterialButton(
                              elevation: 0,
                               padding: EdgeInsets.symmetric(
                                vertical:GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
                              color: Color(ListColor.color4),
                              onPressed: () {
                                controller.validasiSimpan =
                                    controller.form.currentState.validate();

                                if (controller.validasiSimpan) {
                                  controller.onSave();
                                }
                              },
                              child: CustomText(
                                "InfoPraTenderCreateLabelButtonTerapkan"
                                    .tr, // Terapkan
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            )),
                      ])),
                  body: Obx(() => !controller.isloading.value
                      ? Container(
                          margin: EdgeInsets.only(
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                              left:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
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
                                    CustomText(
                                      "InfoPraTenderCreateLabelDiumumkanKepada"
                                              .tr +
                                          "*", // Diumumkan Kepada
                                      color: Color(ListColor.colorGrey3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minHeight:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    46,
                                            minWidth: double.infinity),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(ListColor
                                                      .colorDiumumkanKepada)
                                                  .withOpacity(0.1),
                                              border: Border.all(
                                                  color: Color(ListColor
                                                      .colorLightGrey10)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          5)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      6,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          4),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          right: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              16),
                                                      child: Wrap(
                                                        children: [
                                                          for (var index = 0;
                                                              index <
                                                                  (controller
                                                                              .dataSelectedTampil
                                                                              .value
                                                                              .length >
                                                                          6
                                                                      ? 6
                                                                      : controller
                                                                          .dataSelectedTampil
                                                                          .value
                                                                          .length);
                                                              index++)
                                                            controller
                                                                .selectedTransporterWidget(
                                                                    controller
                                                                            .dataSelectedTampil[
                                                                        index],
                                                                    index)
                                                        ],
                                                      )),
                                                  controller.dataSelectedTampil
                                                              .value.length >
                                                          0
                                                      ? Positioned.fill(
                                                          bottom: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              4,
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child:
                                                                  GestureDetector(
                                                                child: SvgPicture.asset(
                                                                    GlobalVariable
                                                                            .imagePath +
                                                                        'ic_close.svg',
                                                                    width: GlobalVariable.ratioWidth(Get
                                                                            .context) *
                                                                        12,
                                                                    height:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorDarkGrey3)),
                                                                onTap:
                                                                    () async {
                                                                  controller
                                                                      .onReset();
                                                                },
                                                              )))
                                                      : SizedBox(),
                                                ],
                                              )),
                                        )),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            10),
                                    (controller.dataMitraTransporter
                                                    .where((element) =>
                                                        (element['name'] ?? "")
                                                            .toUpperCase()
                                                            .contains(controller
                                                                .searchBar
                                                                .value
                                                                .text
                                                                .toUpperCase()))
                                                    .toList()
                                                    .length ==
                                                0 &&
                                            controller.dataGroup
                                                    .where((element) =>
                                                        (element['name'] ?? "")
                                                            .toUpperCase()
                                                            .contains(controller
                                                                .searchBar
                                                                .value
                                                                .text
                                                                .toUpperCase()))
                                                    .toList()
                                                    .length ==
                                                0 &&
                                            controller.searchBar.value.text != "")
                                        ? Center(
                                            child: Container(
                                                height: MediaQuery.of(Get.context).size.height * 50 / 100,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          "ic_pencarian_tidak_ditemukan.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          82,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          93,
                                                    ),
                                                    SizedBox(
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            15),
                                                    CustomText(
                                                        'InfoPraTenderIndexLabelSearchKeyword'
                                                                .tr +
                                                            '\n' +
                                                            'InfoPraTenderIndexLabelSearchTidakDitemukan'
                                                                .tr, //Keyword Tidak Ditemukan,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textAlign:
                                                            TextAlign.center,
                                                        height: 1.2,
                                                        color: Color(ListColor
                                                            .colorGrey3))
                                                  ],
                                                )))
                                        : Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            controller.expandedWidget(
                                                RichText(
                                                    text: TextSpan(
                                                        text: "InfoPraTenderCreateLabelPilihSemua"
                                                            .tr, // Pilih Semua
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ))),
                                                controller.dataAll.value,
                                                '',
                                                2),
                                            controller.expandedWidget(
                                                RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "InfoPraTenderCreateLabelGroup"
                                                                .tr, // Group
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ))),
                                                controller.dataGroup.value,
                                                'group',
                                                controller.jmlGroup),
                                            controller.expandedWidget(
                                                RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "InfoPraTenderCreateLabelMitra"
                                                                    .tr +
                                                                ' ', //Mitra
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "AvenirNext",
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      Get.context) *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        children: [
                                                      WidgetSpan(
                                                          child: SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "ic_mitra.svg",
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  18,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18)),
                                                      TextSpan(
                                                          text: " / " +
                                                              "InfoPraTenderCreateLabelTransporter"
                                                                  .tr, // Transporter
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "AvenirNext",
                                                            color: Color(ListColor
                                                                .colorDarkGrey3),
                                                            fontSize: GlobalVariable
                                                                    .ratioFontSize(
                                                                        Get.context) *
                                                                12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          children: [])
                                                    ])),
                                                controller
                                                    .dataMitraTransporter.value,
                                                'transporter / mitra',
                                                controller.jmlMitraTransporter),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        25),
                                            controller.searchBar.value.text ==
                                                    ""
                                                ? Column(children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (controller
                                                            .invitedTransporter
                                                            .value) {
                                                          controller
                                                              .invitedTransporter
                                                              .value = false;
                                                        } else if (!controller
                                                            .invitedTransporter
                                                            .value) {
                                                          controller
                                                              .invitedTransporter
                                                              .value = true;
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Obx(() =>
                                                              CheckBoxCustom(
                                                                  size: 14,
                                                                  shadowSize:
                                                                      19,
                                                                  paddingSize:
                                                                      5,
                                                                  isWithShadow:
                                                                      true,
                                                                  value: controller
                                                                      .invitedTransporter
                                                                      .value,
                                                                  onChanged:
                                                                      (value) {
                                                                    controller
                                                                        .invitedTransporter
                                                                        .value = value;
                                                                  })),
                                                          SizedBox(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                7,
                                                          ),
                                                          CustomText(
                                                            "InfoPraTenderCreateLabelInvitedTransporter"
                                                                .tr, // Invited Transporter
                                                            color: Color(ListColor
                                                                .colorDarkGrey3),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          15,
                                                    ),
                                                    controller
                                                            .invitedTransporter
                                                            .value
                                                        ? Obx(() => controller
                                                            .emailInvitationWidget())
                                                        : SizedBox(),
                                                  ])
                                                : SizedBox(),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        20)
                                          ])
                                  ]))))
                      : Center(child: CircularProgressIndicator())))),
        ));
  }

  Future<bool> onWillPop() async {
    controller.onClearSearch();
    Get.back();
  }
}
