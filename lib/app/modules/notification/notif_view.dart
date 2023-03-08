import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_notif.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'final_list.dart';

class NotifViewNew extends GetView<NotifControllerNew> {
  // NotifController controller = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Obx(
        () => SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                child: Container(
                  color: Colors.white,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(context) * 16,
                                    top: GlobalVariable.ratioWidth(context) *
                                        0), //16
                                child: Image.asset(
                                  'assets/backnotif.png',
                                  height:
                                      GlobalVariable.ratioWidth(context) * 24,
                                  width:
                                      GlobalVariable.ratioWidth(context) * 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(context) *
                                      0), //22
                              child: CustomText(
                                'Notifikasi',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),
                                          child: Container(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                178,
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                360,
                                            // color: Colors.red,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            16),
                                                    topLeft: Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            16))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          6,
                                                ),
                                                Center(
                                                    child: Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          3,
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          38,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFDDDDDD),
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              4)),
                                                )),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          20,
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Image.asset(
                                                            'assets/close_other.png',
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                24,
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                24,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  context) *
                                                          82,
                                                    ),
                                                    CustomText(
                                                      'Pilih Notifikasi',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          27,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: CustomText(
                                                        'Tampilkan semua notifikasi',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: Obx(
                                                        () =>
                                                            RadioButtonCustomNotif(
                                                                isDense: true,
                                                                width: GlobalVariable
                                                                        .ratioWidth(
                                                                            context) *
                                                                    20,
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            context) *
                                                                    20,
                                                                isWithShadow:
                                                                    true,
                                                                groupValue: controller
                                                                    .selectedLang
                                                                    .toString(),
                                                                value:
                                                                    controller
                                                                        .indo
                                                                        .value,
                                                                onChanged:
                                                                    (value) async {
                                                                  controller
                                                                      .selectedLang
                                                                      .value = value;
                                                                  controller
                                                                      .contentList
                                                                      .clear();
                                                                  controller.choosesub.value == true ?
                                                                  controller.changemenusub(
                                                                    controller
                                                                        .chosenmenu
                                                                        .value,
                                                                    int.parse(controller
                                                                        .choosensub
                                                                        .value)) :
                                                                  controller.chosenmenu
                                                                              .value ==
                                                                          0
                                                                      ? controller
                                                                          .changemenuall()
                                                                      : controller.changemenu(controller
                                                                          .chosenmenu
                                                                          .value);
                                                                          //danielle
                                                                }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          19,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                context) *
                                                        16,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                context) *
                                                        16,
                                                  ),
                                                  child: Divider(
                                                    thickness: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        0.5,
                                                    color: Color(ListColor
                                                        .colorLightGrey10),
                                                    height: 0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          16,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: CustomText(
                                                        'Tampilkan semua yang belum dibaca',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: Obx(
                                                        () =>
                                                            RadioButtonCustomNotif(
                                                                isDense: true,
                                                                width: GlobalVariable
                                                                        .ratioWidth(
                                                                            context) *
                                                                    20,
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            context) *
                                                                    20,
                                                                isWithShadow:
                                                                    true,
                                                                groupValue: controller
                                                                    .selectedLang
                                                                    .toString(),
                                                                value:
                                                                    controller
                                                                        .eng
                                                                        .value,
                                                                onChanged:
                                                                    (value) async {
                                                                  controller
                                                                      .selectedLang
                                                                      .value = value;
                                                                  controller
                                                                      .contentList
                                                                      .clear();
                                                                  log(controller.chosenmenu.value.toString() + 'danielle');
                                                                  controller.choosesub.value == true ?
                                                                  controller.changemenusubunread(
                                                                    controller
                                                                        .chosenmenu
                                                                        .value,
                                                                    int.parse(controller
                                                                        .choosensub
                                                                        .value)) :
                                                                  controller.chosenmenu
                                                                              .value ==
                                                                          0
                                                                      ? controller
                                                                          .changemenuallunread()
                                                                      : controller.changemenuallunreadkategori(controller
                                                                          .chosenmenu
                                                                          .value.toString());
                                                                }),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(context) * 16,
                                    top: GlobalVariable.ratioWidth(context) *
                                        0), //16
                                child: Image.asset(
                                  'assets/filternotif.png',
                                  height:
                                      GlobalVariable.ratioWidth(context) * 24,
                                  width:
                                      GlobalVariable.ratioWidth(context) * 24,
                                ),
                              ),
                            ),
                          ]),
                      // SizedBox(height: GlobalVariable.ratioWidth(context) * 17),
                      Obx(
                        () => Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius:
                                    GlobalVariable.ratioWidth(context) * 15,
                                offset: Offset(
                                    0, GlobalVariable.ratioWidth(context) * 14),
                                color: Colors.black.withOpacity(
                                    GlobalVariable.ratioWidth(context) * 0.15))
                          ]),
                          height: GlobalVariable.ratioWidth(context) * 42,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              // for(var data in controller.notifList)
                              for (var i = 0;
                                  i < controller.notifList.length;
                                  i++)
                                GestureDetector(
                                  onTap: controller.doneloading.value == false
                                      ? null
                                      : () async {
                                          controller.selectedLang.value = 'true';
                                          controller.choosesub.value = false;
                                          log(controller.notifarray.toString());
                                          controller.unreadsub.value = 0;
                                          controller.choosensub.value = "";
                                          controller.loading2.value = false;
                                          // print(controller.notifList[controller.chosenmenu.value > 0 ? controller.chosenmenu.value-1 : controller.chosenmenu.value].subCategory[0]['SubCategoryName'].length);
                                          // controller.chosenmenu.value = controller.notifList[i].identifier;
                                          controller.chosenmenu.value = i;
                                          //  log(controller.notifList[controller.chosenmenu.value > 0 ? controller.chosenmenu.value-1 : controller.chosenmenu.value].countCategory.toString());
                                          controller.contentList.clear();
                                          controller.chosenmenu.value == 0
                                              ? controller.changemenuall()
                                              : controller.changemenu(
                                                  controller.chosenmenu.value);
                                          //  for(var data in controller.notifList[controller.chosenmenu.value > 0 ? controller.chosenmenu.value-1 : controller.chosenmenu.value].subCategory)
                                          for (var data in controller
                                              .notifList[
                                                  controller.chosenmenu.value]
                                              .subCategory) {
                                            controller.loading2.value = true;
                                            controller.doneloading.value =
                                                false;
                                            log(data['SubCategoryName']
                                                    .toString() +
                                                'ichitan');
                                            log(data.toString() + 'Zehaha');
                                            data['SubCategoryName'].length == 0
                                                ? controller
                                                    .currentlength.value = 0
                                                : controller
                                                    .currentlength.value = 1;
                                            log(controller.currentlength.value
                                                .toString());
                                            var hasil = 0;
                                            var resultx = await ApiHelper(
                                                    context: Get.context,
                                                    isShowDialogLoading: false)
                                                .getCount(
                                                    controller.chosenmenu.value
                                                        .toString(),
                                                    data['Identifier']
                                                        .toString()); //data['Identifier'].toString()
                                            log(resultx['SupportingData']
                                                        ['NotReadCount']
                                                    .toString() +
                                                'Zehaha');
                                            log('Zehaha mugiwara');
                                            log(controller.unread[
                                                    controller.chosenmenu.value]
                                                .toString());
                                            log(controller.chosenmenu.value
                                                    .toString() +
                                                'Zeha');
                                            log(controller.unread[controller
                                                        .chosenmenu.value]
                                                    .toString() +
                                                'Zehah');
                                            // controller.getcountdata(controller.chosenmenu.value, data['Identifier']);
                                            controller.unreadsub.value =
                                                controller.unreadsub.value +
                                                    resultx['SupportingData']
                                                        ['NotReadCount'];
                                            controller.notifarray[controller
                                                        .chosenmenu.value]
                                                    [data['Identifier'] - 1] =
                                                resultx['SupportingData']
                                                        ['NotReadCount']
                                                    .toString();
                                            // log(controller.notifarray[controller.chosenmenu.value][data['Identifier']].toString() + 'Zehaha jujutsu');
                                            // controller.subarray[data['Identifier']] = resultx['SupportingData']['NotReadCount'].toString();
                                          }
                                          controller.doneloading.value = true;
                                          controller.loading2.value = false;
                                        },
                                  child: IntrinsicWidth(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              bottom: BorderSide(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          1,
                                                  color: controller.chosenmenu
                                                              .value ==
                                                          i
                                                      ? Color(0xFF176CF7)
                                                      : Colors.transparent))),
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              42,
                                      width: controller.notifList[i].identifier ==
                                                  0 ||
                                              controller.notifList[i]
                                                      .countCategory >
                                                  0
                                          ? GlobalVariable.ratioWidth(context) *
                                              100
                                          : controller.notifList[i].categoryName
                                                      .replaceAll(
                                                          " - Shipper", "")
                                                      .length >
                                                  5
                                              ? controller.notifList[i]
                                                          .categoryName
                                                          .replaceAll(
                                                              " - Shipper",
                                                              "")
                                                          .length >
                                                      10
                                                  ? GlobalVariable.ratioWidth(
                                                          context) *
                                                      135
                                                  : GlobalVariable.ratioWidth(
                                                          context) *
                                                      88
                                              : GlobalVariable.ratioWidth(context) *
                                                  69,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: CustomText(
                                            controller.notifList[i].categoryName
                                                .replaceAll(
                                                    " - Shipper", ""),
                                            color:
                                                i == controller.chosenmenu.value
                                                    ? Color(0xFF176CF7)
                                                    : Color(0xFFCECECE),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          )),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      context) *
                                                  4),
                                          controller.notifList[i].identifier ==
                                                      0 &&
                                                  controller.totalall.value != 0
                                              ? Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          18,
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          18,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF71717),
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            54),
                                                  ),
                                                  child: Center(
                                                      child: CustomText(
                                                    controller.totalall.value
                                                        .toString(),
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8,
                                                  )))
                                              : Container(),
                                          controller.notifList[i]
                                                      .countCategory ==
                                                  0
                                              ? Container()
                                              : controller.unread[i - 1] == 0
                                                  ? Container()
                                                  : Container(
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  context) *
                                                          18,
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  context) *
                                                          18,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF71717),
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                54),
                                                      ),
                                                      child:
                                                          // Center(child: CustomText(controller.notifList[i].countCategory.toString(), color: Colors.white, fontWeight: FontWeight.w600, fontSize: 8,))
                                                          Center(
                                                              child: CustomText(
                                                        controller.unread[i - 1]
                                                            .toString(),
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 8,
                                                      )))
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(context) * 16,
                            left: GlobalVariable.ratioWidth(context) * 16),
                        child: Container(
                          height: controller
                                      .notifList[controller.chosenmenu.value]
                                      .subCategory[0]['SubCategoryName']
                                      .length ==
                                  0
                              ? GlobalVariable.ratioWidth(context) * 24
                              : GlobalVariable.ratioWidth(context) * 60,
                          child: Obx(
                            () => Column(
                              children: [
                                Container(
                                  // color: Colors.red,
                                  height:
                                      GlobalVariable.ratioWidth(context) * 24,
                                  child: controller.currentlength.value == 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            controller.chosenmenu.value == 0
                                                ? GestureDetector(
                                                    onTap: controller.totalall
                                                                .toString() ==
                                                            '0'
                                                        ? null
                                                        : () async {
                                                            log(controller
                                                                    .notifList[controller
                                                                        .chosenmenu
                                                                        .value]
                                                                    .identifier
                                                                    .toString() +
                                                                'this is the identifier');
                                                            controller
                                                                .updateToReadedAll(
                                                                    controller
                                                                        .totalall
                                                                        .value);
                                                            var resultx = await ApiHelper(
                                                                    context: Get
                                                                        .context,
                                                                    isShowDialogLoading:
                                                                        false)
                                                                .readAllNotif(
                                                                    '3');
                                                            if (resultx !=
                                                                null) {
                                                              controller
                                                                  .unreadsub
                                                                  .value = 0;
                                                              controller
                                                                  .choosensub
                                                                  .value = "";
                                                              controller
                                                                      .loading2
                                                                      .value =
                                                                  false;
                                                              // print(controller.notifList[controller.chosenmenu.value > 0 ? controller.chosenmenu.value-1 : controller.chosenmenu.value].subCategory[0]['SubCategoryName'].length);
                                                              // controller.chosenmenu.value = controller.notifList[i].identifier;
                                                              controller
                                                                  .chosenmenu
                                                                  .value = 0;
                                                              controller
                                                                  .contentList
                                                                  .clear();
                                                              //  log(controller.notifList[controller.chosenmenu.value > 0 ? controller.chosenmenu.value-1 : controller.chosenmenu.value].countCategory.toString());
                                                              controller
                                                                  .changemenuall();
                                                              controller
                                                                  .totalall
                                                                  .value = 0;
                                                              // controller.notifList[controller.chosenmenu.value].identifier == 0 ? null :
                                                              for (var i = 0;
                                                                  i <=
                                                                      controller
                                                                          .unread
                                                                          .length;
                                                                  i++) {
                                                                controller
                                                                        .unread[
                                                                    i] = 0;
                                                              }
                                                            }

                                                            log(controller
                                                                    .notifList[controller
                                                                        .chosenmenu
                                                                        .value]
                                                                    .identifier
                                                                    .toString() +
                                                                'this is the identifier');
                                                          },
                                                    child: CustomText(
                                                      'Tandai sudah dibaca ',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: controller.totalall
                                                                  .value ==
                                                              0
                                                          ? Colors.grey
                                                          : Color(0xFF176CF7),
                                                    ))
                                                : GestureDetector(
                                                    onTap: controller
                                                                .unread[controller
                                                                        .chosenmenu
                                                                        .value -
                                                                    1]
                                                                .toString() ==
                                                            '0'
                                                        ? null
                                                        : () async {
                                                            log('enter');
                                                            log(controller
                                                                    .notifList[controller
                                                                        .chosenmenu
                                                                        .value]
                                                                    .identifier
                                                                    .toString() +
                                                                'the id');
                                                            controller.updateToReadedAll(
                                                                controller
                                                                    .unread[controller
                                                                        .chosenmenu
                                                                        .value -
                                                                    1]);
                                                            var resultx = await ApiHelper(
                                                                    context: Get
                                                                        .context,
                                                                    isShowDialogLoading:
                                                                        false)
                                                                .readAllNotifCategoryID(controller
                                                                    .notifList[controller
                                                                        .chosenmenu
                                                                        .value]
                                                                    .identifier
                                                                    .toString());
                                                            print(resultx
                                                                .toString());
                                                            if (resultx !=
                                                                null) {
                                                              log('enter 2');
                                                              controller
                                                                  .totalall
                                                                  .value = controller
                                                                      .totalall
                                                                      .value -
                                                                  controller
                                                                      .unread[controller
                                                                          .chosenmenu
                                                                          .value -
                                                                      1];
                                                              controller.notifList[controller.chosenmenu.value].identifier ==
                                                                      0
                                                                  ? null
                                                                  : controller
                                                                      .unread[controller
                                                                          .chosenmenu
                                                                          .value -
                                                                      1] = controller
                                                                          .unread[controller
                                                                              .chosenmenu
                                                                              .value -
                                                                          1] -
                                                                      controller
                                                                          .unread[controller
                                                                              .chosenmenu
                                                                              .value -
                                                                          1];
                                                              controller
                                                                  .contentList
                                                                  .clear();
                                                              controller
                                                                  .changemenuall();
                                                            }
                                                            log(controller
                                                                    .notifList[controller
                                                                        .chosenmenu
                                                                        .value]
                                                                    .identifier
                                                                    .toString() +
                                                                'this is the identifier');
                                                          },
                                                    child: CustomText(
                                                      'Tandai sudah dibaca ',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: controller
                                                                  .unread[controller
                                                                      .chosenmenu
                                                                      .value -
                                                                  1] ==
                                                              0
                                                          ? Colors.grey
                                                          : Color(0xFF176CF7),
                                                    )),
                                            CustomText(
                                              controller
                                                          .notifList[controller
                                                              .chosenmenu.value]
                                                          .identifier ==
                                                      0
                                                  ? '(' +
                                                      controller.totalall
                                                          .toString() +
                                                      ')'
                                                  : controller.unread[controller
                                                                  .chosenmenu
                                                                  .value -
                                                              1] ==
                                                          0
                                                      ? ''
                                                      : '(' +
                                                          controller
                                                              .unread[controller
                                                                      .chosenmenu
                                                                      .value -
                                                                  1]
                                                              .toString() +
                                                          ')',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF176CF7),
                                            )
                                          ],
                                        )
                                      : controller.loading2.value == true
                                          ? CircularProgressIndicator()
                                          : ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                for (var data in controller
                                                    .notifList[controller
                                                        .chosenmenu.value]
                                                    .subCategory)
                                                  data['SubCategoryName']
                                                              .length ==
                                                          0
                                                      ? Container()
                                                      : GestureDetector(
                                                          onTap: () {
                                                            controller.selectedLang.value = 'true';
                                                             controller.i.value =
                                                                data[
                                                                    'Identifier'];
                                                            controller.choosesub
                                                                .value = true;
                                                            log(controller
                                                                    .unread[controller
                                                                            .chosenmenu
                                                                            .value -
                                                                        1]
                                                                    .toString() +
                                                                'minji');
                                                            log(controller
                                                                    .notifarray[
                                                                        controller
                                                                            .chosenmenu
                                                                            .value]
                                                                        [
                                                                        data['Identifier'] -
                                                                            1]
                                                                    .toString() +
                                                                'danielle');
                                                            // log(data.toString());
                                                            // controller.chosenmenu.value = data.id;
                                                            // controller.unread[i-1].toString()
                                                            controller
                                                                .choosensub
                                                                .value = data[
                                                                    'Identifier']
                                                                .toString();
                                                            log(controller
                                                                .chosenmenu
                                                                .toString());
                                                            log(controller
                                                                    .choosensub
                                                                    .toString() +
                                                                'lilas');
                                                            // log(controller.unread[0].toString() + 'lilas');
                                                            log(data[
                                                                    'Identifier']
                                                                .toString());
                                                            // controller.i.value =
                                                            //     data[
                                                            //         'Identifier'];
                                                            controller
                                                                .contentList
                                                                .clear();
                                                            controller.chosenmenu.value ==
                                                                    0
                                                                ? controller
                                                                    .changemenuall()
                                                                : controller.changemenusub(
                                                                    controller
                                                                        .chosenmenu
                                                                        .value,
                                                                    int.parse(controller
                                                                        .choosensub
                                                                        .value));
                                                            // log(data['SubCategoryName'].length.toString());
                                                          },
                                                          child: data['SubCategoryName']
                                                                      .length ==
                                                                  0
                                                              ? Container()
                                                              : Padding(
                                                                  padding: EdgeInsets.only(
                                                                      right: GlobalVariable.ratioWidth(
                                                                              context) *
                                                                          12),
                                                                  child:
                                                                      IntrinsicWidth(
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: controller.choosensub.value == data['Identifier'].toString()
                                                                              ? Color(
                                                                                  0xFFD1E2FD)
                                                                              : Colors
                                                                                  .white,
                                                                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) *
                                                                              24),
                                                                          border:
                                                                              Border.all(color: controller.choosensub.value == data['Identifier'].toString() ? Color(0xFF176CF7) : Color(0xFFC6CbD4))),
                                                                      // color: Colors.red,
                                                                      height:
                                                                          GlobalVariable.ratioWidth(context) *
                                                                              24,
                                                                      width: data['SubCategoryName'].length <
                                                                              6
                                                                          ? GlobalVariable.ratioWidth(context) * 60 +
                                                                              (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12)
                                                                          : data['SubCategoryName'].length < 9
                                                                              ? GlobalVariable.ratioWidth(context) * 84 + (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12)
                                                                              : data['SubCategoryName'].length < 14
                                                                                  ? GlobalVariable.ratioWidth(context) * 120 + (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12)
                                                                                  : data['SubCategoryName'].length > 14
                                                                                      ? GlobalVariable.ratioWidth(context) * 170 + (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12)
                                                                                      : data['SubCategoryName'].length > 20
                                                                                          ? GlobalVariable.ratioWidth(context) * 160 + (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12)
                                                                                          : GlobalVariable.ratioWidth(context) * 200 + (data['CountSubCategory'] == 0 ? 0 : GlobalVariable.ratioWidth(context) * 12),
                                                                      child: Center(
                                                                          child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Center(
                                                                              child: CustomText(
                                                                            data['SubCategoryName'].replaceAll(" - Shipper", "").replaceAll("Lokasi Truk Siap Muat",
                                                                                "LTSM"),
                                                                            color: controller.choosensub.value == data['Identifier'].toString()
                                                                                ? Color(0xFF176CF7)
                                                                                : Color(0xFF676767),
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize:
                                                                                14,
                                                                          )),
                                                                          SizedBox(
                                                                            width:
                                                                                GlobalVariable.ratioWidth(context) * 4,
                                                                          ),
                                                                          // controller.notifarray[controller.chosenmenu.value][data['Identifier']].toString() == "0" ?
                                                                          data['CountSubCategory'] == 0
                                                                              ? Container()
                                                                              : Container(
                                                                                  height: GlobalVariable.ratioWidth(context) * 18,
                                                                                  width: GlobalVariable.ratioWidth(context) * 18,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFF71717),
                                                                                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 54),
                                                                                  ),
                                                                                  child:
                                                                                      // data['CountSubCategory']
                                                                                      Center(
                                                                                          child: CustomText(
                                                                                    controller.notifarray[controller.chosenmenu.value][data['Identifier'] - 1],
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 8,
                                                                                  ))
                                                                                  // Center(child: CustomText(controller.notifarray[controller.chosenmenu.value][data['Identifier']-1].toString(), color: Colors.white, fontWeight: FontWeight.w600, fontSize: 8,))
                                                                                  )
                                                                        ],
                                                                      )),
                                                                    ),
                                                                  ),
                                                                ),
                                                        )
                                              ],
                                            ),
                                ),
                                controller.currentlength.value > 0
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    context) *
                                                17),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            controller.chosenmenu.value == 0
                                                ? GestureDetector(
                                                    onTap: () {
                                                      log(controller
                                                              .notifList[
                                                                  controller
                                                                      .chosenmenu
                                                                      .value]
                                                              .identifier
                                                              .toString() +
                                                          'this is the identifier');
                                                    },
                                                    child: CustomText(
                                                      'Tandai sudah dibaca ',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: controller.totalall
                                                                  .value ==
                                                              0
                                                          ? Colors.grey
                                                          : Color(0xFF176CF7),
                                                    ))
                                                : GestureDetector(
                                                    onTap: () async {
                                                      log(controller
                                                          .notifList[controller
                                                              .chosenmenu.value]
                                                          .identifier
                                                          .toString());
                                                      //                                 var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).readAllNotif('3', kategori);
                                                      // if(resultx != null){
                                                      // // controller.totalall.value = controller.totalall.value - 1;
                                                      // controller.notifList[controller.chosenmenu.value].identifier == 0 ? null :
                                                      // controller.unread[controller.chosenmenu.value - 1] = 0;
                                                      // }
                                                    },
                                                    child: GestureDetector(
                                                        onTap: controller
                                                                    .unreadsub
                                                                    .value
                                                                    .toString() ==
                                                                '0'
                                                            ? null
                                                            : controller.choosesub
                                                                        .value ==
                                                                    true
                                                                ? () async {
                                                                    log('refo');
                                                                    log(controller
                                                                            .choosensub
                                                                            .toString() +
                                                                        'ikura');
                                                                    log(controller
                                                                            .notifarray[controller.chosenmenu.value][controller.i.value -
                                                                                1]
                                                                            .toString() +
                                                                        'haerin');
                                                                    // controller.updateToReadedAll(controller.unread[controller.chosenmenu.value - 1]);
                                                                    log('success');
                                                                    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).readAllNotifSub(controller
                                                                        .notifList[controller
                                                                            .chosenmenu
                                                                            .value]
                                                                        .identifier
                                                                        .toString());
                                                                    if (resultx !=
                                                                        null) {
                                                                      controller
                                                                          .totalall
                                                                          .value = controller
                                                                              .totalall
                                                                              .value -
                                                                          controller.notifarray[controller
                                                                              .chosenmenu
                                                                              .value][controller
                                                                                  .i.value -
                                                                              1];
                                                                      controller.notifList[controller.chosenmenu.value].identifier ==
                                                                              0
                                                                          ? null
                                                                          : controller.unread[controller.chosenmenu.value -
                                                                              1] = controller.unread[controller.chosenmenu.value -
                                                                                  1] -
                                                                              controller.notifarray[controller.chosenmenu.value][controller.i.value - 1];
                                                                      controller.notifarray[controller
                                                                          .chosenmenu
                                                                          .value][controller
                                                                              .i
                                                                              .value -
                                                                          1] = controller.notifarray[controller.chosenmenu.value]
                                                                              [controller.i.value - 1] -
                                                                          controller.notifarray[controller.chosenmenu.value][controller.i.value - 1];
                                                                    }
                                                                    //haerin
                                                                    //  controller.updateToReadedAll(controller.unread[controller.chosenmenu.value - 1]);
                                                                    // controller.chosenmenu.toString()
                                                                  }
                                                                : () async {
                                                                    // controller.unreadsub.value.toString() == '0' ?
                                                                    // log('there is no data') :
                                                                    log(controller
                                                                            .notifList[controller.chosenmenu.value]
                                                                            .identifier
                                                                            .toString() +
                                                                        'Shoro');
                                                                    controller.updateToReadedAll(controller
                                                                        .unread[controller
                                                                            .chosenmenu
                                                                            .value -
                                                                        1]);
                                                                    var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).readAllNotifCategoryID(controller
                                                                        .notifList[controller
                                                                            .chosenmenu
                                                                            .value]
                                                                        .identifier
                                                                        .toString());
                                                                    log(resultx
                                                                        .toString());
                                                                    if (resultx !=
                                                                        null) {
                                                                      controller
                                                                          .totalall
                                                                          .value = controller
                                                                              .totalall
                                                                              .value -
                                                                          controller.unread[controller.chosenmenu.value -
                                                                              1];
                                                                      controller.notifList[controller.chosenmenu.value].identifier ==
                                                                              0
                                                                          ? null
                                                                          : controller.unread[controller.chosenmenu.value -
                                                                              1] = controller.unread[controller.chosenmenu.value -
                                                                                  1] -
                                                                              controller.unread[controller.chosenmenu.value - 1];
                                                                    }
                                                                    log(controller
                                                                            .notifList[controller.chosenmenu.value]
                                                                            .identifier
                                                                            .toString() +
                                                                        'this is the identifier');
                                                                    //
                                                                  },
                                                        child: CustomText(
                                                          'Tandai sudah dibaca ',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: controller
                                                                      .unread[controller
                                                                          .chosenmenu
                                                                          .value -
                                                                      1] ==
                                                                  0
                                                              ? Colors.grey
                                                              : 
                                                              controller.notifarray[controller.chosenmenu.value][controller.i.value-1 < 0 ? 0 : controller.i.value-1].toString() == '0'?
                                                              Colors.grey :
                                                              Color(
                                                                  0xFF176CF7),
                                                        ))),
                                            controller.unreadsub.value
                                                        .toString() ==
                                                    '0'
                                                ? Container()
                                                : 
                                                controller.choosesub.value == true?
                                                controller.notifarray[controller.chosenmenu.value][controller.i.value-1].toString() == '0'?
                                                Container() :
                                                CustomText(
                                                    '(' +
                                                        controller.notifarray[controller.chosenmenu.value][controller.i.value-1].toString() +
                                                        ')',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF176CF7),
                                                  ) :
                                                CustomText(
                                                    '(' +
                                                        controller
                                                            .unreadsub.value
                                                            .toString() +
                                                        ')',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF176CF7),
                                                  )
                                            // CustomText('Tandai sudah dibaca ', fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF176CF7),),
                                            //    CustomText(controller.notifList[controller.chosenmenu.value].identifier == 0 ? '(' + controller.totalall.toString() + ')' : controller.unread[controller.chosenmenu.value - 1] == 0 ? '(0)' :'(' + controller.unread[controller.chosenmenu.value - 1].toString() + ')', fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF176CF7),)
                                          ],
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: controller.notifList[controller.chosenmenu.value]
                            .subCategory[0]['SubCategoryName'].length ==
                        0
                    ? Size.fromHeight(GlobalVariable.ratioWidth(context) * 138)
                    : Size.fromHeight(
                        GlobalVariable.ratioWidth(context) * 174,
                        //98
                      ),
              ),
              // preferredSize: controller.notifList[controller.chosenmenu.value].subCategory[0]['SubCategoryName'].length == 0 ? Size.fromHeight(GlobalVariable.ratioWidth(context) * 138) : Size.fromHeight(GlobalVariable.ratioWidth(context) * 174,
              // //98
              // ),
              // ),
              body: SafeArea(
                  child: Container(
                // color: Color(0xFFC6CBD4),
                color: Colors.white,
                child: Obx(() => controller.contentList.isEmpty
                    ? Center(
                        child: controller.loading.value == true
                            ? CircularProgressIndicator()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/lonceng.png',
                                    height:
                                        GlobalVariable.ratioWidth(context) * 75,
                                    width:
                                        GlobalVariable.ratioWidth(context) * 75,
                                  ),
                                  SizedBox(
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              19),
                                  CustomText('Anda belum',
                                      color: Color(0xFF868686),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                  CustomText('menerima notifikasi',
                                      color: Color(0xFF868686),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ],
                              ))
                    : ListView.builder(
                        itemCount: controller.contentList.length,
                        itemBuilder: (context, index) {
                          return notifTile(
                              controller.contentList[index], index);
                        },
                      )),
              ))),
        ),
      ),
    );
  }

  Widget notifTile(FinalList notif, int index) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFFC6CBD4)),
          ),
          color: notif.statusread != 0 ? Color(0xFFFFFFFF) : Color(0xFFD1E2FD)),
      // margin: EdgeInsets.only(bottom: 1),
      duration: Duration(milliseconds: 500),
      // curve: Curves.easeInOut,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () async {},
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: EdgeInsets.only(right: 20),
              //   width: 60,
              //   height: 60,
              //   decoration: notif.image.isNotEmpty
              //       ? null
              //       : BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(40)),
              //           color: Colors.white,
              //           border: Border.all(
              //               color: Color(ListColor.color4), width: 1)),
              //   padding: EdgeInsets.all(notif.image.isEmpty ? 10 : 0),
              //   child:
              //   notif.image.isEmpty
              //       ? Icon(
              //           Icons.notifications,
              //         )
              //       : CircleAvatar(
              //           backgroundImage: NetworkImage(notif.image),
              //         ),
              // ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      notif.judul,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    CustomText(
                      notif.deskripsi,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color(0xFF868686),
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    CustomText(
                      notif.timenotif,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: Color(0xFF868686),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: notif.statusread == 1
                      ? null
                      : () async {
                          // controller.updateToReaded(index);
                          // var resultx = await ApiHelper(
                          //         context: Get.context,
                          //         isShowDialogLoading: false)
                          //     .readSingleNotif(notif.id.toString());
                          // if (resultx != null) {
                          //   log(notif.id.toString());
                          //   controller.totalall.value =
                          //       controller.totalall.value - 1;
                          //   controller.notifList[controller.chosenmenu.value]
                          //               .identifier ==
                          //           0
                          //       ? null
                          //       : controller.unread[
                          //               controller.chosenmenu.value - 1] =
                          //           controller.unread[
                          //                   controller.chosenmenu.value - 1] -
                          //               1;
                          // }

                          showMaterialModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: Get.context,
                                    builder: (context) => SingleChildScrollView(
                                          controller:
                                              ModalScrollController.of(context),
                                          child: Container(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                120,
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                360,
                                            // color: Colors.red,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            16),
                                                    topLeft: Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            16))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          6,
                                                ),
                                                Center(
                                                    child: Container(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          3,
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          38,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFDDDDDD),
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              4)),
                                                )),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          20,
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(
                                                                      context) *
                                                              16),
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Image.asset(
                                                            'assets/close_other.png',
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                24,
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                24,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  context) *
                                                          118,
                                                    ),
                                                    CustomText(
                                                      'Menu',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              context) *
                                                          27,
                                                ),
                                                GestureDetector(
                                                  onTap:
                                                  notif.statusread == 1
                                                  ? null : 
                                                  () async{
                                                     controller.updateToReaded(index);
                                                      var resultx = await ApiHelper(
                                                              context: Get.context,
                                                              isShowDialogLoading: false)
                                                          .readSingleNotif(notif.id.toString());
                                                      if (resultx != null) {
                                                        log(notif.id.toString());
                                                        controller.totalall.value =
                                                            controller.totalall.value - 1;
                                                         Navigator.pop(context);
                                                        //  for(var i = 0 ; i < controller.unread.length ; i ++)
                                                        //  {
                                                        //   log(controller.unread[i].toString());
                                                        //  }
                                                         for(var i = 1; i < controller.notifList.length ; i ++)
                                                         {
                                                          log(controller.notifList[i].identifier.toString() + ' minji');
                                                          var resultx = await ApiHelper(context: Get.context, isShowDialogLoading: false).getListNotifKategori(controller.notifList[i].identifier.toString());
                                                          log('get result minji');
                                                          log(resultx.toString() + 'minjiii');
                                                          log('result done minji');
                                                          if(resultx['Data'].toString().contains(notif.id.toString()))
                                                          {
                                                          log('bro masuk');
                                                          log('minji ayee');
                                                          log(notif.id.toString() + ' minjiii');
                                                          log(controller.notifList[i].identifier.toString() + ' minjiii');
                                                            for(var i = 0 ; i < controller.unreadid.length ; i++){
                                                              if(controller.unreadid[i].toString() == controller.notifList[i+1].identifier.toString()){
                                                              //  log('minjiiii' + controller.unread[controller.unreadid[i]-1].toString());
                                                              log('minji kurangi');
                                                              controller.unread[controller.unreadid[i]-1] = controller.unread[controller.unreadid[i]-1] -1;
                                                              controller.unreadsub.value =  controller.unreadsub.value - 1;
                                                              controller.notifarray[controller.chosenmenu.value][controller.i.value -1] = controller.notifarray[controller.chosenmenu.value][controller.i.value -1] -1;
                                                              // controller.unread[controller.unreadid[i]] = controller.unread[controller.unreadid[i]] - 1; 
                                                             
                                                            }
                                                            log('minji ' + i.toString());
                                                            log('minji ' + controller.unreadid[i].toString());
                                                            log('minji ' + controller.notifList[i+1].identifier.toString());
                                                            log(controller.unreadid[i].toString() + ' minji');
                                                            // controller.unreadid[i-1].toString() == controller.notifList[i].identifier.toString() ?
                                                            // log('minji sama' + i.toString()) : null;
                                                          }
                                                          log('minji oyee');
                                                          }
                                                          
                                                          // {
                                                          //   log(notif.id.toString() + ' minjiii');
                                                          // //   for(var i = 0 ; i < controller.unreadid.length ; i++){
                                                          // //     log(controller.unreadid[i].value.toString() + ' minji');
                                                          // //   // controller.unreadid[i].value.toString() == notif.id.toString() ?
                                                          // //   // log('sama minji' + i.toString()) : null;
                                                          // // }

                                                          // }
                                                          // log(resultx.toString() + ' minji');
                                                         }
                                                        //  log(controller.unread[
                                                        //             controller.chosenmenu.value - 1].toString());
                                                        // controller.notifList[controller.chosenmenu.value]
                                                        //             .identifier ==
                                                        //         0
                                                        //     ? null
                                                        //     : controller.unread[
                                                        //             controller.chosenmenu.value - 1] =
                                                        //         controller.unread[
                                                        //                 controller.chosenmenu.value - 1] -
                                                        //             1;
                                                         
                                                  }
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: GlobalVariable
                                                                .ratioWidth(
                                                                    context) *
                                                            16),
                                                    child: CustomText(
                                                      'Tandai Sudah Dibaca',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                        },
                  child: Image.asset('assets/othernew.png',
                      height: GlobalVariable.ratioWidth(Get.context) * 20,
                      width: GlobalVariable.ratioWidth(Get.context) * 20)),
              // CustomText('nnn')
            ],
          ),
        ),
      ),
    );
  }
}
