import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import 'test_list_controller.dart';
import 'dart:math' as math;

class TestListView extends GetView<TestListController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          // floatingActionButton:
          //     Obx(() => controller.firstTab.value && !controller.listMitra.value
          //         ? FloatingActionButton(
          //             onPressed: () {
          //               Get.toNamed(Routes.CREATE_GROUP_MITRA);
          //             },
          //             child: Icon(Icons.add, color: Colors.white),
          //           )
          //         : SizedBox.shrink()),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(110),
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ], color: Color(ListColor.color4)),
              child: Stack(alignment: Alignment.bottomRight, children: [
                Positioned(
                  right: -10,
                  bottom: 10,
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Container(
                      width: 10,
                      height: 65,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.5)
                          ])),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: -10,
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Container(
                      width: 30,
                      height: 65,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.3)
                          ])),
                    ),
                  ),
                ),
                Positioned(
                  right: 75,
                  bottom: 20,
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Container(
                      width: 30,
                      height: 115,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0)
                          ])),
                    ),
                  ),
                ),
                Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: ClipOval(
                            child: Material(
                                shape: CircleBorder(),
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          size: 20,
                                          color: Color(ListColor.color4),
                                        ))))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText("Test List",
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ],
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.tabController.animateTo(0);
                              },
                              child: Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText("List Design 1",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: controller.isTabDesign1.value
                                                ? Colors.white
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                          )),
                                    ]),
                              ),
                            ),
                          )),
                          Expanded(
                              child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.tabController.animateTo(1);
                              },
                              child: Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText("List Design 2",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                      Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: controller.isTabDesign2.value
                                                ? Colors.white
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                          )),
                                    ]),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ]),
              ]),
            ),
          ),

          // AppBar(
          //   automaticallyImplyLeading: false,
          //   title: Stack(alignment: Alignment.bottomRight, children: [
          //     Positioned(
          //       right: -10,
          //       bottom: -10,
          //       child: Transform.rotate(
          //         angle: -math.pi / 4,
          //         child: Container(
          //           width: 10,
          //           height: 50,
          //           decoration: BoxDecoration(
          //               gradient: LinearGradient(
          //                   begin: Alignment.topCenter,
          //                   end: Alignment.bottomCenter,
          //                   colors: [
          //                 Colors.white.withOpacity(0),
          //                 Colors.white.withOpacity(0.5)
          //               ])),
          //         ),
          //       ),
          //     ),
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Container(
          //           child: ClipOval(
          //             child: Material(
          //                 shape: CircleBorder(),
          //                 color: Colors.white,
          //                 child: InkWell(
          //                     onTap: () {
          //                       Get.back();
          //                     },
          //                     child: Container(
          //                         width: 30,
          //                         height: 30,
          //                         child: Center(
          //                             child: Icon(
          //                           Icons.arrow_back_ios_rounded,
          //                           size: 20,
          //                           color: Color(ListColor.color4),
          //                         ))))),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Expanded(
          //           child: Stack(
          //             alignment: Alignment.centerLeft,
          //             children: [
          //               Obx(
          //                 () => TextField(
          //                     controller: controller.textEditingController.value,
          //                     decoration: InputDecoration(
          //                       hintText: controller.firstTab.value
          //                           ? "PartnerManagementLabelHintSearchMitra".tr
          //                           : "PartnerManagementLabelHintSearchGroup".tr,
          //                       fillColor: Colors.white,
          //                       filled: true,
          //                       contentPadding: EdgeInsets.only(left: 42),
          //                       border: OutlineInputBorder(
          //                         borderSide: BorderSide(
          //                             color: Color(ListColor.color4), width: 1.0),
          //                         borderRadius: BorderRadius.circular(10),
          //                       ),
          //                     )),
          //               ),
          //               Container(
          //                 margin: EdgeInsets.only(left: 7),
          //                 child: SvgPicture.asset(
          //                   "assets/search_magnifition_icon.svg",
          //                   width: 30,
          //                   height: 30,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           width: 10.0,
          //         ),
          //         SvgPicture.asset("assets/sorting_icon.svg"),
          //       ],
          //     ),
          //   ]),
          //   //Text("BigFleetsLabelMenuManagementPartners".tr),
          //   // bottom: TabBar(
          //   //   controller: controller.tabController,
          //   //   tabs: [
          //   //     Tab(child: Text("PartnerManagementLabelMitra".tr)),
          //   //     Tab(child: Text("PartnerManagementLabelGroup".tr)),
          //   //     // Tab(child: Text("PartnerManagementTabRequest".tr)),
          //   //     // Tab(child: Text("PartnerManagementTabPending".tr)),
          //   //   ],
          //   // ),
          // ),
          body: TabBarView(controller: controller.tabController, children: [
            listMitra1(),
            listMitra2()
          ]), //[listMitra(), listRequest(), listPending()]
          bottomNavigationBar: BottomAppBarMuat(
            centerItemText: '',
            color: Colors.grey,
            backgroundColor: Colors.white,
            selectedColor: Color(ListColor.colorSelectedBottomMenu),
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (index) {
              switch (index) {
                case 0:
                  {
                    //Get.toNamed(Routes.INBOX);
                    break;
                  }
                case 1:
                  {
                    //Get.toNamed(Routes.PROFILE_SHIPPER);
                    break;
                  }
              }
            },
            items: [
              BottomAppBarItemModel(
                  iconName: 'message_menu_icon.svg', text: ''),
              BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
            ],
            iconSize: 40,
          ),
          // body: _list[_page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(),
            child: FloatingActionButton(
              backgroundColor: Color(ListColor.colorGreen2),
              onPressed: () async {
                // if (controller.tabController.index == 1) {
                //   var result = await Get.toNamed(Routes.CREATE_GROUP_MITRA);
                //   if (result != null && result == "create") {
                //     CustomToast.show(
                //         context: context,
                //         message: "Group has been created",
                //         onTap: null);
                //   } else if (result != null && result == "edit") {
                //     CustomToast.show(
                //         context: context,
                //         message: "Group has been edited",
                //         onTap: null);
                //   }
                // }
                //Get.toNamed(Routes.FIND_TRUCK);
              },
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 60,
              ),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  side: BorderSide(color: Colors.white, width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget mitraTile2(MitraModel mitraModel,
      {bool isShowMoreHoriz = false, void Function() onTapMoreHoriz}) {
    double borderRadius = 10;
    return Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
        // margin:
        //     EdgeInsets.fromLTRB(11, 11, 11, index != (totalIndex - 1) ? 0 : 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(ListColor.color4).withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Center(
                        child: CustomText(mitraModel.initials,
                            color: Colors.white)),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            SvgPicture.asset("assets/golden_icon.svg",
                                width: 25, height: 25),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomText(mitraModel.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                          SizedBox(height: 5),
                          CustomText(mitraModel.city,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4))
                        ],
                      ),
                    ),
                  ),
                  isShowMoreHoriz && onTapMoreHoriz != null
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onTapMoreHoriz,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 20,
                                )),
                          ))
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius))),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _itemDescMitra("assets/support_area_icon.svg",
                            mitraModel.areaLayanan),
                        _itemDescMitra("assets/type_truck_icon.svg",
                            mitraModel.yearFounded),
                        _itemDescMitra("assets/number_truck_icon.svg",
                            mitraModel.qtyAreaLayanan),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.color4),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.TRANSPORTER, arguments: [
                              mitraModel.id,
                              mitraModel.name,
                              mitraModel.avatar,
                              mitraModel.isGold
                            ]);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: CustomText(
                                    'PartnerManagementLabelDetail'.tr,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))),
                    ),
                  )
                ],
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Expanded(
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           _itemDescMitra("assets/support_area_icon.svg",
              //               mitraModel.areaLayanan),
              //           _itemDescMitra("assets/type_truck_icon.svg",
              //               mitraModel.yearFounded),
              //           _itemDescMitra("assets/number_truck_icon.svg",
              //               mitraModel.qtyAreaLayanan),
              //         ],
              //       ),
              //     ),
              //     Material(
              //       borderRadius: BorderRadius.circular(20),
              //       color: Color(ListColor.color4),
              //       child: InkWell(
              //           customBorder: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //           onTap: () {
              //             Get.toNamed(Routes.TRANSPORTER,
              //                 arguments: [true, 2]);
              //           },
              //           child: Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 30, vertical: 8),
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(20)),
              //               child: Center(
              //                 child: Text('PartnerManagementLabelDetail'.tr,
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.w600)),
              //               ))),
              //     ),
              //   ],
              // )
            ),
          ],
        ));
  }

  Widget mitraTileKey(MitraModel mitraModel) {
    double borderRadius = 10;
    return Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
        // margin:
        //     EdgeInsets.fromLTRB(11, 11, 11, index != (totalIndex - 1) ? 0 : 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(children: [
          Container(
            key: controller.mitraTileKey.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(ListColor.color4).withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: Center(
                            child: CustomText(mitraModel.initials,
                                color: Colors.white)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SvgPicture.asset("assets/golden_icon.svg",
                                    width: 25, height: 25),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: CustomText(mitraModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              SizedBox(height: 5),
                              CustomText(mitraModel.city,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))
                            ],
                          ),
                        ),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _showMenuMore();
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 20,
                                )),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius))),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _itemDescMitra("assets/support_area_icon.svg",
                                mitraModel.areaLayanan),
                            _itemDescMitra("assets/type_truck_icon.svg",
                                mitraModel.yearFounded),
                            _itemDescMitra("assets/number_truck_icon.svg",
                                mitraModel.qtyAreaLayanan),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 120,
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Color(ListColor.color4),
                      //     child: InkWell(
                      //         customBorder: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         onTap: () {
                      //           Get.toNamed(Routes.TRANSPORTER,
                      //               arguments: [true, mitraModel.id]);
                      //         },
                      //         child: Container(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 30, vertical: 8),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20)),
                      //             child: Center(
                      //               child: Text(
                      //                   'PartnerManagementLabelDetail'.tr,
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.w600)),
                      //             ))),
                      //   ),
                      // )
                    ],
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           _itemDescMitra("assets/support_area_icon.svg",
                  //               mitraModel.areaLayanan),
                  //           _itemDescMitra("assets/type_truck_icon.svg",
                  //               mitraModel.yearFounded),
                  //           _itemDescMitra("assets/number_truck_icon.svg",
                  //               mitraModel.qtyAreaLayanan),
                  //         ],
                  //       ),
                  //     ),
                  //     Material(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Color(ListColor.color4),
                  //       child: InkWell(
                  //           customBorder: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           onTap: () {
                  //             Get.toNamed(Routes.TRANSPORTER,
                  //                 arguments: [true, 2]);
                  //           },
                  //           child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: 30, vertical: 8),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(20)),
                  //               child: Center(
                  //                 child: Text('PartnerManagementLabelDetail'.tr,
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w600)),
                  //               ))),
                  //     ),
                  //   ],
                  // )
                ),
              ],
            ),
          ),
        ]));
  }

  Widget mitraTile3(MitraModel mitraModel) {
    double borderRadius = 10;
    return Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
        // margin:
        //     EdgeInsets.fromLTRB(11, 11, 11, index != (totalIndex - 1) ? 0 : 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(children: [
          Container(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(ListColor.color4).withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: Center(
                            child: CustomText(mitraModel.initials,
                                color: Colors.white)),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SvgPicture.asset("assets/golden_icon.svg",
                                    width: 25, height: 25),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: CustomText(mitraModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              SizedBox(height: 5),
                              CustomText(mitraModel.city,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius))),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _itemDescMitra("assets/support_area_icon.svg",
                                mitraModel.areaLayanan),
                            _itemDescMitra("assets/type_truck_icon.svg",
                                mitraModel.yearFounded),
                            _itemDescMitra("assets/number_truck_icon.svg",
                                mitraModel.qtyAreaLayanan),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: 120,
                      //   child: Material(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Color(ListColor.color4),
                      //     child: InkWell(
                      //         customBorder: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         onTap: () {
                      //           Get.toNamed(Routes.TRANSPORTER,
                      //               arguments: [true, mitraModel.id]);
                      //         },
                      //         child: Container(
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 30, vertical: 8),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20)),
                      //             child: Center(
                      //               child: Text(
                      //                   'PartnerManagementLabelDetail'.tr,
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.w600)),
                      //             ))),
                      //   ),
                      // )
                    ],
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           _itemDescMitra("assets/support_area_icon.svg",
                  //               mitraModel.areaLayanan),
                  //           _itemDescMitra("assets/type_truck_icon.svg",
                  //               mitraModel.yearFounded),
                  //           _itemDescMitra("assets/number_truck_icon.svg",
                  //               mitraModel.qtyAreaLayanan),
                  //         ],
                  //       ),
                  //     ),
                  //     Material(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Color(ListColor.color4),
                  //       child: InkWell(
                  //           customBorder: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           onTap: () {
                  //             Get.toNamed(Routes.TRANSPORTER,
                  //                 arguments: [true, 2]);
                  //           },
                  //           child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: 30, vertical: 8),
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(20)),
                  //               child: Center(
                  //                 child: Text('PartnerManagementLabelDetail'.tr,
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w600)),
                  //               ))),
                  //     ),
                  //   ],
                  // )
                ),
              ],
            ),
          ),
          Material(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: () {
                  Get.toNamed(Routes.TRANSPORTER,
                      arguments: [2, "", "", false]);
                },
                child: Container(
                    width: controller.widthMitraTile.value,
                    height: controller.heightMitraTile.value),
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _showMenuMore();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.more_horiz,
                          size: 20,
                        )),
                  )),
            ),
          )
        ]));
  }

  Widget _itemDescMitra(String urlIcon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(urlIcon, width: 25, height: 25),
          SizedBox(width: 16),
          Expanded(
              child: CustomText(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Color(ListColor.colorGrey4)))
        ],
      ),
    );
  }

  Widget mitraTile(String type, int index, int totalIndex) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(11, 11, 11, index != (totalIndex - 1) ? 0 : 11),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            side: BorderSide(color: Color(ListColor.color4), width: 2)),
        onPressed: () {
          Get.toNamed(Routes.TRANSPORTER, arguments: [2, "", "", false]);
        },
        padding: EdgeInsets.all(11),
        minWidth: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/gambar_example.jpeg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("PT. Truk Maju Bersama",
                        fontWeight: FontWeight.bold, fontSize: 15),
                    Stack(
                      children: [
                        CustomText("Gold Transporter",
                            fontSize: 14,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.yellow),
                        CustomText("Gold Transporter",
                            color: Colors.orange, fontSize: 14),
                      ],
                    ),
                    Container(height: 5),
                    CustomText("PartnerManagementTransporterLocation".tr,
                        fontWeight: FontWeight.bold),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CustomText("Surabaya", fontSize: 13),
                    ),
                    CustomText("PartnerManagementServiceArea".tr,
                        fontWeight: FontWeight.bold),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CustomText("Jawa, Sumatera, Bali.", fontSize: 13),
                    ),
                    CustomText("PartnerManagementEstablishedYear".tr,
                        fontWeight: FontWeight.bold),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CustomText("2001", fontSize: 13),
                    ),
                    CustomText("PartnerManagementTruckTotal".tr,
                        fontWeight: FontWeight.bold),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: CustomText("200 unit", fontSize: 13),
                    ),
                    type != "list"
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 7),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 20),
                                color: Color(ListColor.color4),
                                onPressed: () {
                                  popupDialogue(
                                      "PartnerManagementDeleteConfirmation".tr,
                                      () {
                                    Navigator.of(Get.context).pop();
                                  });
                                },
                                child: CustomText(
                                    "PartnerManagementLabelDelete".tr,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    type != "request"
                        ? SizedBox.shrink()
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 7),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 20),
                                color: Color(ListColor.color4),
                                onPressed: () {
                                  popupDialogue(
                                      "PartnerManagementCancelConfirmation".tr,
                                      () {
                                    Navigator.of(Get.context).pop();
                                  });
                                },
                                child: CustomText(
                                    "PartnerManagementLabelCancel".tr,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    type != "pending"
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 7),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Color(ListColor.color4),
                                          width: 2)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 20),
                                  color: Colors.white,
                                  onPressed: () {
                                    popupDialogue(
                                        "PartnerManagementApproveConfirmation"
                                            .tr, () {
                                      Navigator.of(Get.context).pop();
                                    });
                                  },
                                  child: CustomText(
                                      "PartnerManagementLabelApprove".tr,
                                      color: Color(ListColor.color4)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 7),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 20),
                                  color: Color(ListColor.color4),
                                  onPressed: () {
                                    popupDialogue(
                                        "PartnerManagementRejectConfirmation"
                                            .tr, () {
                                      Navigator.of(Get.context).pop();
                                    });
                                  },
                                  child: CustomText(
                                      "PartnerManagementLabelReject",
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  popupDialogue(String content, Function() onAgree) {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            content: CustomText(content),
            actions: [
              MaterialButton(
                onPressed: () => onAgree(),
                child: CustomText("PartnerManagementLabelSure".tr),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CustomText("PartnerManagementLabelCancel".tr),
              )
            ],
          );
        });
  }

  Widget listMitra1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => controller.isShowMitraTileKey.value
            ? mitraTileKey(controller.mitraModelExample.value)
            : Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _listAllMitraDesign1()),
                    ]),
              )),
      ],
    );
  }

  Widget listMitra2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _listAllMitraDesign2()),
      ],
    );
  }

  Widget _listAllMitraDesign1() {
    return ListView.builder(
      itemCount: controller.listMitra.length,
      itemBuilder: (content, index) {
        return mitraTile2(controller.listMitra[index]);
      },
    );
  }

  Widget _listAllMitraDesign2() {
    return ListView.builder(
      itemCount: controller.listMitra.length,
      itemBuilder: (content, index) {
        return mitraTile3(controller.listMitra[index]);
      },
    );
  }

  void _showMenuMore() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(Get.context).size.width,
            color: Colors.transparent,
            //height: MediaQuery.of(context).size.height - 100,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.close_rounded)),
                  _itemMoreMitra("Edit Data", Icons.create_rounded),
                  _lineSaparatorTabMitra(),
                  _itemMoreMitra("Delete Data", Icons.delete),
                ]),
          );
        });
  }

  Widget _itemMoreMitra(String title, IconData icon) {
    return InkWell(
        onTap: () {
          //controller.setTabMitraValue(titleID, subTitle);
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 10),
              CustomText(title,
                  color: Colors.black, fontWeight: FontWeight.w600),
            ],
          ),
        ));
  }

  Widget _lineSaparatorTabMitra() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5));
  }
}
