import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_detail_manajemen_group_mitra/search_detail_manajemen_group_mitra_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import 'package:muatmuat/global_variable.dart';
import 'detail_manajemen_group_mitra_controller.dart';

class DetailManajemenGroupMitraView
    extends GetView<DetailManajemenGroupMitraController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      color: Color(ListColor.colorBlue),
      child: WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(false);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: _AppBarCustom(
                showClear: false,
                isEnableSearchTextField: false,
                hintText: "Cari Nama Mitra".tr,
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) * 56),
                searchInput: controller.textEditingController,
                listOption: [
                  Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                  // Obx(
                  //   () =>
                  GestureDetector(
                      onTap: () {
                        // if (!(controller.listData.length <= 1 &&
                        //     controller.filterKota.isEmpty &&
                        //     controller.filterProvince.isEmpty))
                        //   controller.showSort();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                // controller.sort.keys.isNotEmpty
                                //     ? Colors.white
                                //     :
                                Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/sorting_icon.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color:
                                  // (controller.listData.length <= 1 &&
                                  //         controller.filterKota.isEmpty &&
                                  //         controller.filterProvince.isEmpty)
                                  //     ? Color(ListColor.colorLightGrey2)
                                  //     : controller.sort.keys.isNotEmpty
                                  //         ?
                                  // Color(ListColor.color4):
                                  Colors.white))),
                  // )
                ],
                onSelect: () async {
                  // if (!(controller.listData.length <= 1 &&
                  //     controller.filterKota.isEmpty &&
                  //     controller.filterProvince.isEmpty)) {
                  var result = await GetToPage.toNamed<
                          SearchDetailManajemenGroupMitraController>(
                      Routes.SEARCH_DETAIL_MANAJEMEN_GROUP_MITRA,
                      arguments: [
                        controller.listMitra.value,
                        controller.groupID
                      ]);
                  if (result != null) {}

                  // controller.addListenerSearch(() {
                  //   controller.refreshData();
                  // });
                  // }
                }),

            // AppBar(
            //   backgroundColor: Color(ListColor.color4),
            //   automaticallyImplyLeading: false,
            //   title: Container(
            //     child: Stack(alignment: Alignment.bottomRight, children: [
            //       // Positioned(
            //       //   width: 30,
            //       //   height: 30,
            //       //   child: SvgPicture.asset(
            //       //     "assets/fallin_star_icon.svg",
            //       //     width: 30,
            //       //     height: 30,
            //       //   ),
            //       // ),
            //       Row(
            //         mainAxisSize: MainAxisSize.max,
            //         children: [
            //           Container(
            //             child: ClipOval(
            //               child: Material(
            //                   shape: CircleBorder(),
            //                   color: Colors.white,
            //                   child: InkWell(
            //                       onTap: () {
            //                         Get.back();
            //                       },
            //                       child: Container(
            //                           width: 30,
            //                           height: 30,
            //                           child: Center(
            //                               child: Icon(
            //                             Icons.arrow_back_ios_rounded,
            //                             size: 20,
            //                             color: Color(ListColor.color4),
            //                           ))))),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Expanded(
            //             child: Stack(
            //               alignment: Alignment.centerLeft,
            //               children: [
            //                 CustomTextField(
            //                     context: Get.context,
            //                     controller: controller.textEditingController,
            //                     onChanged: (text) {
            //                       controller.updateFilter();
            //                     },
            //                     newContentPadding: EdgeInsets.symmetric(
            //                           horizontal: 42, vertical: 2),
            //                     newInputDecoration: InputDecoration(
            //                       hintText: "Cari Group",
            //                       fillColor: Colors.white,
            //                       filled: true,
            //                       border: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             color: Color(ListColor.color4), width: 1.0),
            //                         borderRadius: BorderRadius.circular(10),
            //                       ),
            //                       enabledBorder: OutlineInputBorder(
            //                         borderSide: BorderSide(
            //                             color: Color(ListColor.colorLightGrey7),
            //                             width: 1.0),
            //                         borderRadius: BorderRadius.circular(10),
            //                       ),
            //                     )),
            //                 Container(
            //                   margin: EdgeInsets.only(left: 7),
            //                   child: SvgPicture.asset(
            //                     "assets/search_magnifition_icon.svg",
            //                     width: 30,
            //                     height: 30,
            //                   ),
            //                 ),
            //                 Align(
            //                   alignment: Alignment.centerRight,
            //                   child: Container(
            //                     margin: EdgeInsets.only(right: 5),
            //                     child: Material(
            //                         color: Colors.transparent,
            //                         child: InkWell(
            //                             onTap: () {
            //                               controller.textEditingController.text = "";
            //                             },
            //                             child: Container(
            //                                 width: 30,
            //                                 height: 30,
            //                                 child: Center(
            //                                     child: Icon(
            //                                   Icons.close,
            //                                   size: 30,
            //                                   color: Colors.black,
            //                                 ))))),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10.0,
            //           ),
            //           SvgPicture.asset(
            //             "assets/sorting_icon.svg",
            //             color: Colors.white,
            //           ),
            //         ],
            //       ),
            //     ]),
            //   ),
            //   // bottom: TabBar(
            //   //   controller: controller.tabController,
            //   //   tabs: [
            //   //     Tab(child: Text("PartnerManagementTabList".tr)),
            //   //     Tab(child: Text("Group Mitra".tr)),
            //   //     // Tab(child: Text("PartnerManagementTabRequest".tr)),
            //   //     // Tab(child: Text("PartnerManagementTabPending".tr)),
            //   //   ],
            //   // ),
            // ),

            body: WillPopScope(
              onWillPop: () {
                Get.back(result: controller.change);
                return Future.value(false);
              },
              child: Container(
                  color: Color(ListColor.colorLightGrey6),
                  child: Obx(
                    () => controller.loading.value
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            width: Get.context.mediaQuery.size.width,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator()),
                                ),
                                CustomText("ListTransporterLabelLoading".tr),
                              ],
                            ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20,
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          72,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          72,
                                                      child: CircleAvatar(
                                                        radius: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            30.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                GlobalVariable
                                                                        .urlImage +
                                                                    controller
                                                                        .group
                                                                        .value
                                                                        .avatar),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        child: Obx(
                                                          () => Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Obx(
                                                                () =>
                                                                    CustomText(
                                                                  controller
                                                                      .group
                                                                      .value
                                                                      .name,
                                                                  fontSize: 16,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorDarkGrey4),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      6),
                                                              CustomText(
                                                                  "${controller.listMitra.value == null ? "-" : controller.listMitra.length} " +
                                                                      "PartnerManagementLabelPartner"
                                                                          .tr,
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorGrey4),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              Container(
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      9),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  _button(
                                                                      height:
                                                                          24,
                                                                      paddingLeft:
                                                                          12,
                                                                      paddingRight:
                                                                          12,
                                                                      marginRight:
                                                                          6,
                                                                      text: controller
                                                                              .groupStatus
                                                                              .value
                                                                          ? "PartnerManagementLabelNonAktifkan"
                                                                              .tr
                                                                          : "PartnerManagementLabelAktifkan"
                                                                              .tr,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      onTap:
                                                                          () {
                                                                        controller.checkEnableGroupToggle(!controller
                                                                            .groupStatus
                                                                            .value);
                                                                      }),
                                                                  _button(
                                                                    height: 24,
                                                                    paddingLeft:
                                                                        12,
                                                                    paddingRight:
                                                                        12,
                                                                    text:
                                                                        "Hapus",
                                                                    borderColor: Color(!controller
                                                                            .group
                                                                            .value
                                                                            .isDelete
                                                                        ? ListColor
                                                                            .colorLightGrey2
                                                                        : ListColor
                                                                            .colorBlue),
                                                                    color: Color(!controller
                                                                            .group
                                                                            .value
                                                                            .isDelete
                                                                        ? ListColor
                                                                            .colorLightGrey2
                                                                        : ListColor
                                                                            .colorBlue),
                                                                    onTap: !controller
                                                                            .group
                                                                            .value
                                                                            .isDelete
                                                                        ? null
                                                                        : () {
                                                                            controller.removeGroup();
                                                                          },
                                                                  ),

                                                                  // GestureDetector(
                                                                  //     onTap: () {
                                                                  //       controller.checkEnableGroupToggle(!controller
                                                                  //           .groupStatus
                                                                  //           .value);
                                                                  //     },
                                                                  //     child: Container(
                                                                  //         decoration: BoxDecoration(
                                                                  //             border: Border.all(
                                                                  //                 color: Color(ListColor
                                                                  //                     .color4),
                                                                  //                 width:
                                                                  //                     2),
                                                                  //             borderRadius: BorderRadius.all(Radius.circular(
                                                                  //                 15))),
                                                                  //         padding: EdgeInsets.symmetric(
                                                                  //             horizontal:
                                                                  //                 10,
                                                                  //             vertical:
                                                                  //                 4),
                                                                  //         child: Obx(() => CustomText(
                                                                  //             controller.groupStatus.value ? "PartnerManagementLabelNonAktifkan".tr : "PartnerManagementLabelAktifkan".tr,
                                                                  //             fontWeight: FontWeight.bold,
                                                                  //             color: Color(ListColor.color4))))),
                                                                  // Container(
                                                                  //     width: 10),
                                                                  // Obx(
                                                                  //   () =>
                                                                  //       GestureDetector(
                                                                  //           onTap: !controller
                                                                  //                   .group.value.isDelete
                                                                  //               ? null
                                                                  //               : () {
                                                                  //                   controller.removeGroup();
                                                                  //                 },
                                                                  //           child: Container(
                                                                  //               decoration:
                                                                  //                   BoxDecoration(border: Border.all(color: controller.group.value.isDelete ? Color(ListColor.color4) : Colors.grey, width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                                                                  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                                  //               child: CustomText("Hapus", fontWeight: FontWeight.bold, color: controller.group.value.isDelete ? Color(ListColor.color4) : Colors.grey))),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          20),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(
                                                    () => CustomText(
                                                        controller.group.value
                                                                .description ??
                                                            "",
                                                        height: 1.6,
                                                        color: Color(ListColor
                                                            .colorGrey3),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                                      .tempListMitra.value ==
                                                  null
                                              ? 0
                                              : controller.tempListMitra.length,
                                          itemBuilder: (content, index) {
                                            var mitra =
                                                controller.tempListMitra[index];
                                            return _mitraTile(
                                                index,
                                                controller.tempListMitra.length,
                                                mitra);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 56,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Color(ListColor.colorBlack)
                                            .withOpacity(0.16),
                                        blurRadius: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            55,
                                        spreadRadius: 0,
                                        offset: Offset(
                                            0,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                -3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: _button(
                                            height: 32,
                                            marginLeft: 16,
                                            marginRight: 4,
                                            borderRadius: 26,
                                            backgroundColor:
                                                Color(ListColor.colorBlue),
                                            customWidget: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                  child: SvgPicture.asset(
                                                    "assets/ic_add_1,5.svg",
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                  ),
                                                ),
                                                CustomText(
                                                  "PartnerManagementLabelAddMember"
                                                      .tr,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(
                                                      ListColor.colorWhite),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              controller.showListMitra();
                                            })
                                        // Material(
                                        //   borderRadius: BorderRadius.circular(20),
                                        //   color: Color(ListColor.color4),
                                        //   child: InkWell(
                                        //       customBorder: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(20),
                                        //       ),
                                        //       onTap: () {
                                        //         controller.showListMitra();
                                        //       },
                                        //       child: Container(
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 10, vertical: 8),
                                        //           decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(20)),
                                        //           child: Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.center,
                                        //               mainAxisSize: MainAxisSize.max,
                                        //               children: [
                                        //                 SvgPicture.asset(
                                        //                   "assets/add_icon.svg",
                                        //                   width: 20,
                                        //                   height: 20,
                                        //                 ),
                                        //                 SizedBox(width: 8),
                                        //                 Expanded(
                                        //                   child: CustomText(
                                        //                       "PartnerManagementLabelAddMember"
                                        //                           .tr,
                                        //                       textAlign:
                                        //                           TextAlign.center,
                                        //                       color: Colors.white,
                                        //                       fontWeight:
                                        //                           FontWeight.w600),
                                        //                 )
                                        //               ]))),
                                        // ),

                                        ),
                                    Expanded(
                                      child: _button(
                                          height: 32,
                                          marginLeft: 4,
                                          marginRight: 16,
                                          borderRadius: 26,
                                          customWidget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        8),
                                                child: SvgPicture.asset(
                                                  "assets/ic_edit_group.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                ),
                                              ),
                                              CustomText(
                                                "PartnerManagementLabelEditGroup"
                                                    .tr,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Color(ListColor.colorBlue),
                                              ),
                                            ],
                                          ),
                                          onTap: () async {
                                            var result = await Get.toNamed(
                                                Routes.EDIT_GROUP_MITRA,
                                                arguments: [
                                                  List<MitraModel>.from(
                                                      controller
                                                          .listMitra.value),
                                                  controller.group.value
                                                ]);
                                            if (result != null &&
                                                result is GroupMitraModel) {
                                              controller.loading.value = true;
                                              controller.group.value = result;
                                              controller.change = true;
                                              CustomToast.show(
                                                  context: Get.context,
                                                  message:
                                                      "PartnerManagementGroupHasBeenUpdated"
                                                          .tr);
                                              await controller
                                                  .getListMitraOnGroup();
                                              controller.loading.value = false;
                                            }
                                          }),
                                      // Material(
                                      //   borderRadius: BorderRadius.circular(20),
                                      //   color: Colors.white,
                                      //   child: InkWell(
                                      //       customBorder: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(20),
                                      //       ),
                                      //       onTap: () async {
                                      //         var result = await Get.toNamed(
                                      //             Routes.EDIT_GROUP_MITRA,
                                      //             arguments: [
                                      //               List<MitraModel>.from(
                                      //                   controller.listMitra.value),
                                      //               controller.group.value
                                      //             ]);
                                      //         if (result != null &&
                                      //             result is GroupMitraModel) {
                                      //           controller.loading.value = true;
                                      //           controller.group.value =
                                      //               result as GroupMitraModel;
                                      //           controller.change = true;
                                      //           CustomToast.show(
                                      //               context: Get.context,
                                      //               message:
                                      //                   "PartnerManagementGroupHasBeenUpdated"
                                      //                       .tr);
                                      //           await controller
                                      //               .getListMitraOnGroup();
                                      //           controller.loading.value = false;
                                      //         }
                                      //       },
                                      //       child: Container(
                                      //           padding: EdgeInsets.symmetric(
                                      //               horizontal: 10, vertical: 8),
                                      //           decoration: BoxDecoration(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(20),
                                      //               border: Border.all(
                                      //                   width: 1,
                                      //                   color: Color(
                                      //                       ListColor.color4))),
                                      //           child: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment.center,
                                      //               mainAxisSize: MainAxisSize.max,
                                      //               children: [
                                      //                 SvgPicture.asset(
                                      //                   "assets/edit_icon.svg",
                                      //                   width: 20,
                                      //                   height: 20,
                                      //                 ),
                                      //                 SizedBox(width: 8),
                                      //                 Expanded(
                                      //                   child: CustomText(
                                      //                       "PartnerManagementLabelEditGroup"
                                      //                           .tr,
                                      //                       textAlign:
                                      //                           TextAlign.center,
                                      //                       color: Color(
                                      //                           ListColor.color4),
                                      //                       fontWeight:
                                      //                           FontWeight.w600),
                                      //                 ),
                                      //               ]))),
                                      // ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  )

                  // Stack(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Expanded(
                  //           child: SingleChildScrollView(
                  //             child: Obx(
                  //               () => Column(
                  //                 children: [
                  //                   controller.textEditingController.text.isNotEmpty
                  //                       ? SizedBox.shrink()
                  //                       : Container(
                  //                           padding: EdgeInsets.only(
                  //                               top: 10, left: 10, right: 10),
                  //                           child: Column(
                  //                               mainAxisSize: MainAxisSize.min,
                  //                               children: [
                  //                                 Row(
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     CircleAvatar(
                  //                                       radius: 30.0,
                  //                                       backgroundImage: NetworkImage(
                  //                                           GlobalVariable.urlImage +
                  //                                               controller.group.value
                  //                                                   .avatar),
                  //                                       backgroundColor:
                  //                                           Colors.transparent,
                  //                                     ),
                  //                                     Expanded(
                  //                                       child: Container(
                  //                                         margin: EdgeInsets.only(
                  //                                             left: 11),
                  //                                         child: Obx(
                  //                                           () => Column(
                  //                                             crossAxisAlignment:
                  //                                                 CrossAxisAlignment
                  //                                                     .start,
                  //                                             children: [
                  //                                               Obx(
                  //                                                 () => CustomText(
                  //                                                     controller.group
                  //                                                         .value.name,
                  //                                                     fontSize: 18,
                  //                                                     fontWeight:
                  //                                                         FontWeight
                  //                                                             .w700),
                  //                                               ),
                  //                                               SizedBox(height: 6),
                  //                                               CustomText(
                  //                                                   "${controller.listMitra.value == null ? "-" : controller.listMitra.length} " +
                  //                                                       "PartnerManagementLabelPartner"
                  //                                                           .tr,
                  //                                                   color: Color(ListColor
                  //                                                       .colorLightGrey4),
                  //                                                   fontWeight:
                  //                                                       FontWeight
                  //                                                           .w500),
                  //                                               Container(height: 10),
                  //                                               Row(
                  //                                                 mainAxisSize:
                  //                                                     MainAxisSize
                  //                                                         .max,
                  //                                                 mainAxisAlignment:
                  //                                                     MainAxisAlignment
                  //                                                         .start,
                  //                                                 children: [
                  //                                                   GestureDetector(
                  //                                                       onTap: () {
                  //                                                         controller.checkEnableGroupToggle(!controller
                  //                                                             .groupStatus
                  //                                                             .value);
                  //                                                       },
                  //                                                       child: Container(
                  //                                                           decoration: BoxDecoration(
                  //                                                               border: Border.all(
                  //                                                                   color: Color(ListColor
                  //                                                                       .color4),
                  //                                                                   width:
                  //                                                                       2),
                  //                                                               borderRadius: BorderRadius.all(Radius.circular(
                  //                                                                   15))),
                  //                                                           padding: EdgeInsets.symmetric(
                  //                                                               horizontal:
                  //                                                                   10,
                  //                                                               vertical:
                  //                                                                   4),
                  //                                                           child: Obx(() => CustomText(
                  //                                                               controller.groupStatus.value ? "PartnerManagementLabelNonAktifkan".tr : "PartnerManagementLabelAktifkan".tr,
                  //                                                               fontWeight: FontWeight.bold,
                  //                                                               color: Color(ListColor.color4))))),
                  //                                                   Container(
                  //                                                       width: 10),
                  //                                                   Obx(
                  //                                                     () =>
                  //                                                         GestureDetector(
                  //                                                             onTap: !controller
                  //                                                                     .group.value.isDelete
                  //                                                                 ? null
                  //                                                                 : () {
                  //                                                                     controller.removeGroup();
                  //                                                                   },
                  //                                                             child: Container(
                  //                                                                 decoration:
                  //                                                                     BoxDecoration(border: Border.all(color: controller.group.value.isDelete ? Color(ListColor.color4) : Colors.grey, width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                  //                                                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  //                                                                 child: CustomText("Hapus", fontWeight: FontWeight.bold, color: controller.group.value.isDelete ? Color(ListColor.color4) : Colors.grey))),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                             ],
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(height: 14),
                  //                                 Container(
                  //                                   alignment: Alignment.centerLeft,
                  //                                   child: Obx(
                  //                                     () => CustomText(
                  //                                         controller.group.value
                  //                                             .description,
                  //                                         height: 1.5,
                  //                                         color: Color(
                  //                                             ListColor.colorGrey3),
                  //                                         fontWeight:
                  //                                             FontWeight.w500),
                  //                                   ),
                  //                                 ),
                  //                               ]),
                  //                         ),
                  //                   SizedBox(height: 10),
                  //                   ListView.builder(
                  //                     physics: ClampingScrollPhysics(),
                  //                     shrinkWrap: true,
                  //                     itemCount:
                  //                         controller.tempListMitra.value == null
                  //                             ? 0
                  //                             : controller.tempListMitra.length,
                  //                     itemBuilder: (content, index) {
                  //                       var mitra = controller.tempListMitra[index];
                  //                       return _mitraTile(index,
                  //                           controller.tempListMitra.length, mitra);
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(10),
                  //                   topRight: Radius.circular(10))),
                  //           child: ClipRRect(
                  //               borderRadius: BorderRadius.only(
                  //                 topRight: Radius.circular(10),
                  //                 topLeft: Radius.circular(10),
                  //               ),
                  //               child: Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 color: Colors.white,
                  //                 child: Row(
                  //                   mainAxisSize: MainAxisSize.max,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Material(
                  //                         borderRadius: BorderRadius.circular(20),
                  //                         color: Color(ListColor.color4),
                  //                         child: InkWell(
                  //                             customBorder: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(20),
                  //                             ),
                  //                             onTap: () {
                  //                               controller.showListMitra();
                  //                             },
                  //                             child: Container(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                     horizontal: 10, vertical: 8),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(20)),
                  //                                 child: Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.center,
                  //                                     mainAxisSize: MainAxisSize.max,
                  //                                     children: [
                  //                                       SvgPicture.asset(
                  //                                         "assets/add_icon.svg",
                  //                                         width: 20,
                  //                                         height: 20,
                  //                                       ),
                  //                                       SizedBox(width: 8),
                  //                                       Expanded(
                  //                                         child: CustomText(
                  //                                             "PartnerManagementLabelAddMember"
                  //                                                 .tr,
                  //                                             textAlign:
                  //                                                 TextAlign.center,
                  //                                             color: Colors.white,
                  //                                             fontWeight:
                  //                                                 FontWeight.w600),
                  //                                       )
                  //                                     ]))),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Expanded(
                  //                       child: Material(
                  //                         borderRadius: BorderRadius.circular(20),
                  //                         color: Colors.white,
                  //                         child: InkWell(
                  //                             customBorder: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(20),
                  //                             ),
                  //                             onTap: () async {
                  //                               var result = await Get.toNamed(
                  //                                   Routes.EDIT_GROUP_MITRA,
                  //                                   arguments: [
                  //                                     List<MitraModel>.from(
                  //                                         controller.listMitra.value),
                  //                                     controller.group.value
                  //                                   ]);
                  //                               if (result != null &&
                  //                                   result is GroupMitraModel) {
                  //                                 controller.loading.value = true;
                  //                                 controller.group.value =
                  //                                     result as GroupMitraModel;
                  //                                 controller.change = true;
                  //                                 CustomToast.show(
                  //                                     context: Get.context,
                  //                                     message:
                  //                                         "PartnerManagementGroupHasBeenUpdated"
                  //                                             .tr);
                  //                                 await controller
                  //                                     .getListMitraOnGroup();
                  //                                 controller.loading.value = false;
                  //                               }
                  //                             },
                  //                             child: Container(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                     horizontal: 10, vertical: 8),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(20),
                  //                                     border: Border.all(
                  //                                         width: 1,
                  //                                         color: Color(
                  //                                             ListColor.color4))),
                  //                                 child: Row(
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment.center,
                  //                                     mainAxisSize: MainAxisSize.max,
                  //                                     children: [
                  //                                       SvgPicture.asset(
                  //                                         "assets/edit_icon.svg",
                  //                                         width: 20,
                  //                                         height: 20,
                  //                                       ),
                  //                                       SizedBox(width: 8),
                  //                                       Expanded(
                  //                                         child: CustomText(
                  //                                             "PartnerManagementLabelEditGroup"
                  //                                                 .tr,
                  //                                             textAlign:
                  //                                                 TextAlign.center,
                  //                                             color: Color(
                  //                                                 ListColor.color4),
                  //                                             fontWeight:
                  //                                                 FontWeight.w600),
                  //                                       ),
                  //                                     ]))),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               )
                  //               // Container(
                  //               //     height: 50,
                  //               //     width: MediaQuery.of(Get.context).size.width,
                  //               //     decoration: BoxDecoration(
                  //               //         color: Colors.white,
                  //               //         borderRadius: BorderRadius.only(
                  //               //             topLeft: Radius.circular(20),
                  //               //             topRight: Radius.circular(20)))),
                  //               ),
                  //         ),
                  //       ],
                  //     ),

                  //     !controller.loading.value
                  //         ? SizedBox.shrink()
                  //         : Positioned.fill(
                  //             child: Container(
                  //                 alignment: Alignment.center,
                  //                 color: Color(0xBB000000),
                  //                 child: Container(
                  //                   padding: EdgeInsets.all(13),
                  //                   color: Colors.black,
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     children: [
                  //                       CircularProgressIndicator(),
                  //                       Container(
                  //                           margin:
                  //                               EdgeInsets.symmetric(vertical: 13),
                  //                           child: CustomText("Loading",
                  //                               color: Colors.white))
                  //                     ],
                  //                   ),
                  //                 )))
                  //   ],
                  // ),
                  // ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelFilter(int index) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () {
              //Get.toNamed(Routes.PLACE_FAVORITE);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 1, color: Color(ListColor.colorLightGrey))),
              child:
                  CustomText("Label -" + index.toString(), color: Colors.blue),
            )),
      ),
    );
  }

  Widget _mitraTile(int index, int totalIndex, MitraModel mitra) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
          ),
        ],
        borderRadius: BorderRadius.all(
            Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          vertical: GlobalVariable.ratioWidth(Get.context) * 12),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 14),
              width: GlobalVariable.ratioWidth(Get.context) * 32,
              height: GlobalVariable.ratioWidth(Get.context) * 32,
              child: CircleAvatar(
                radius: GlobalVariable.ratioWidth(Get.context) * 25.0,
                backgroundImage:
                    NetworkImage(GlobalVariable.urlImage + mitra.avatar),
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          mitra.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(mitra.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color(ListColor.colorGrey4)),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 6,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/support_area_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.areaLayanan,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/type_truck_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.yearFounded,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              child: SvgPicture.asset(
                                "assets/number_truck_icon.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                            ),
                            Expanded(
                              child: CustomText(mitra.qtyTruck + " unit",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  color: Color(ListColor.colorGrey4),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(
                          marginLeft: 8,
                          marginBottom: 4,
                          text: "PartnerManagementLabelDetail".tr,
                          width: 72,
                          height: 24,
                          backgroundColor: Color(ListColor.colorBlue),
                          onTap: () {
                            Get.toNamed(Routes.TRANSPORTER, arguments: [
                              mitra.id,
                              mitra.name,
                              mitra.avatar,
                              mitra.isGold
                            ]);
                          }),
                      _button(
                          marginLeft: 8,
                          marginTop: 4,
                          text: "PartnerManagementLabelHapus".tr,
                          width: 72,
                          height: 24,
                          color: Color(ListColor.colorBlue),
                          onTap: () {
                            controller.hapusMitra(mitra);
                          })
                    ],
                  ),
                ],
              ),
            ),

            //NOPE2
            // Expanded(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Row(
            //         mainAxisSize: MainAxisSize.max,
            //         children: [

            //           Expanded(
            //             child: Container(
            //               margin: EdgeInsets.only(left: 11),
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [

            //                   SizedBox(height: 5),

            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(height: 5),

            //       SizedBox(
            //         height: 12,
            //       ),

            //       SizedBox(
            //         height: 12,
            //       ),

            //     ],
            //   ),
            // ),
            // Container(width: 10),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     MaterialButton(
            //         color: Color(ListColor.color4),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //           side: BorderSide(color: Color(ListColor.color4), width: 2),
            //         ),
            //         onPressed: () {
            //           Get.toNamed(Routes.TRANSPORTER, arguments: [
            //             mitra.id,
            //             mitra.name,
            //             mitra.avatar,
            //             mitra.isGold
            //           ]);
            //         },
            //         child: CustomText("PartnerManagementLabelDetail".tr,
            //             color: Colors.white, fontWeight: FontWeight.w600)),
            //     MaterialButton(
            //         padding: EdgeInsets.symmetric(vertical: 4),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //           side: BorderSide(color: Color(ListColor.color4), width: 2),
            //         ),
            //         onPressed: () {
            //           controller.hapusMitra(mitra);
            //         },
            //         child: CustomText("PartnerManagementLabelHapus".tr,
            //             color: Color(ListColor.color4),
            //             fontWeight: FontWeight.w600)),
            //   ],
            // )
          ]),
      //NOPE
      // child: FlatButton(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(11)),
      //       side: BorderSide(color: Color(ListColor.color4), width: 2)),
      //   onPressed: () {
      //     Get.toNamed(Routes.GROUP_MITRA);
      //   },
      //   padding: EdgeInsets.all(11),
      //   minWidth: 0,
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         width: 70,
      //         height: 70,
      //         decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image: AssetImage("assets/gambar_example.jpeg"),
      //                 fit: BoxFit.cover),
      //             borderRadius: BorderRadius.all(Radius.circular(35))),
      //       ),
      //       Expanded(
      //         child: Container(
      //           margin: EdgeInsets.only(left: 11),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Group $index",
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //               Text("20 partner")
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = true,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: onTap == null
                ? null
                : () {
                    onTap();
                  },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}

class _AppBarCustom extends PreferredSize {
  final TextEditingController searchInput;
  final String hintText;
  final List<Widget> listOption;
  final Function(String) onSearch;
  final Function(String) onChange;
  final Function() onSelect;
  final Function() onClear;
  final bool isEnableSearchTextField;
  final bool showClear;

  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DetailManajemenGroupMitraController>();
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 5,
              right: 0,
              child: Image(
                image: AssetImage("assets/fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                      context: Get.context,
                      onTap: () {
                        controller.onWillPop();
                        // Get.back();
                      }),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: onSelect != null && !isEnableSearchTextField
                              ? GestureDetector(
                                  onTap: onSelect, child: _searchTextField)
                              : _searchTextField)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: listOption,
                  )
                ],
              ),
            )
          ])),
    ));
  }

  Widget get _searchTextField => Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                context: Get.context,
                enabled: isEnableSearchTextField,
                controller: searchInput,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.go,
                style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvenirNext",
                    color: Colors.black),
                newInputDecoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey2)),
                    filled: true,
                    isDense: true,
                    isCollapsed: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 36,
                        GlobalVariable.ratioWidth(Get.context) * 9,
                        GlobalVariable.ratioWidth(Get.context) * 32,
                        GlobalVariable.ratioWidth(Get.context) * 0)),
                onSubmitted: (String str) async {
                  await onSearch(str);
                },
                onChanged: (String str) async {
                  await onChange(str);
                },
                onTap: () async {
                  if (!onSelect.isNull) await onSelect();
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 6),
            child: SvgPicture.asset(
              "assets/ic_search.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 20,
              height: GlobalVariable.ratioWidth(Get.context) * 20,
            ),
          ),
          showClear
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () async {
                      searchInput.clear();
                      await onClear();
                    },
                  ))
              : SizedBox.shrink()
        ],
      );

  _AppBarCustom({
    this.hintText = "Search",
    this.preferredSize,
    this.searchInput,
    this.listOption,
    this.onSearch,
    this.onChange,
    this.onClear,
    this.onSelect,
    this.isEnableSearchTextField = true,
    this.showClear = false,
  });
}
