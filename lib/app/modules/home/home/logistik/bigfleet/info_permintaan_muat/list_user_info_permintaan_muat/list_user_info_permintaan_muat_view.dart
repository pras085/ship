import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/appbar_custom2.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ListUserInfoPermintaanMuatView
    extends GetView<ListUserInfoPermintaanMuatController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom2(
            preferredSize: Size.fromHeight(_appBar.preferredSize.height + 10),
            searchInput: controller.searchBar,
            listOption: [],
            onSearch: (String str) async {
              controller.transporterSearch.value = str;
              controller.refreshData();
            },
            onChange: (String str) async {
              controller.transporterSearch.value = str;
              controller.startTimerGetMitra();
            },
            onClear: () async {
              controller.transporterSearch.value = "";
              controller.refreshData();
            }),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: GlobalVariable.ratioWidth(Get.context) * 10),
                  child: Obx(
                    () => Stack(
                      children: [
                        controller.loading.value
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
                                    CustomText(
                                        "ListTransporterLabelLoading".tr),
                                    // Text("Loading"),
                                  ],
                                ))
                            : SizedBox.shrink(),
                        !controller.loading.value &&
                                controller.listGroupSearch.length == 0 &&
                                controller.listTransporterSearch.length == 0
                            ? Container(
                                color: Colors.grey[100],
                                alignment: Alignment.center,
                                child: CustomText("Data not found"))
                            : SizedBox.shrink(),
                        controller.loading.value
                            ? SizedBox.shrink()
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    16,
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Diumumkan kepada",
                                                      style: TextStyle(
                                                          color: Color(ListColor
                                                              .colorGrey3),
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(Get
                                                                      .context) *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                  TextSpan(
                                                      text: "*",
                                                      style: TextStyle(
                                                          color: Color(ListColor
                                                              .colorRed),
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(Get
                                                                      .context) *
                                                              12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Stack(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  constraints: BoxConstraints(
                                                      minHeight: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          50,
                                                      maxHeight: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          252),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          10,
                                                      vertical: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          6),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              5),
                                                      border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          width: GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              1)),
                                                  child: Scrollbar(
                                                    isAlwaysShown: true,
                                                    controller: controller
                                                        .scrollbarController,
                                                    child:
                                                        SingleChildScrollView(
                                                      controller: controller
                                                          .scrollbarController,
                                                      child: Obx(
                                                        () => Wrap(
                                                          spacing: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              4,
                                                          runSpacing: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              6,
                                                          children: [
                                                            for (var index = 0;
                                                                index <
                                                                    controller
                                                                        .selectedJenisMitra
                                                                        .length;
                                                                index++)
                                                              wrapItem(
                                                                  controller
                                                                      .selectedJenisMitra
                                                                      .values
                                                                      .toList()[index],
                                                                  () {
                                                                controller
                                                                    .selectedJenisMitra
                                                                    .removeWhere((key,
                                                                            value) =>
                                                                        key ==
                                                                        controller
                                                                            .selectedJenisMitra
                                                                            .keys
                                                                            .toList()[index]);
                                                                controller
                                                                    .updateJumlahMitra();
                                                              }),
                                                            for (var index = 0;
                                                                index <
                                                                    (controller.limitTampil - controller.selectedJenisMitra.length >
                                                                            controller
                                                                                .selectedGroup.length
                                                                        ? controller
                                                                            .selectedGroup
                                                                            .length
                                                                        : controller.limitTampil -
                                                                            controller
                                                                                .selectedJenisMitra.length);
                                                                index++)
                                                              wrapItem(
                                                                  controller.selectedGroup[
                                                                          index]
                                                                      ["Name"],
                                                                  () {
                                                                controller
                                                                    .selectedGroup
                                                                    .removeAt(
                                                                        index);
                                                                controller
                                                                    .updateJumlahMitra();
                                                              }),
                                                            for (var index = 0;
                                                                index <
                                                                    (controller.limitTampil - (controller.selectedJenisMitra.length + controller.selectedGroup.length) >
                                                                            controller
                                                                                .selectedTransporter.length
                                                                        ? controller
                                                                            .selectedTransporter
                                                                            .length
                                                                        : controller.limitTampil -
                                                                            (controller.selectedJenisMitra.length +
                                                                                controller
                                                                                    .selectedGroup.length));
                                                                index++)
                                                              wrapItem(
                                                                  controller.selectedTransporter[
                                                                          index]
                                                                      ["name"],
                                                                  () {
                                                                controller
                                                                    .selectedTransporter
                                                                    .removeAt(
                                                                        index);
                                                                controller
                                                                    .updateJumlahMitra();
                                                              }),
                                                            for (var index = 0;
                                                                index <
                                                                    (controller.limitTampil - (controller.selectedJenisMitra.length + controller.selectedGroup.length + controller.selectedTransporter.length) >
                                                                            controller
                                                                                .totalInvited.value
                                                                        ? controller
                                                                            .totalInvited
                                                                            .value
                                                                        : controller
                                                                                .limitTampil -
                                                                            (controller.selectedJenisMitra.length +
                                                                                controller
                                                                                    .selectedGroup.length +
                                                                                controller
                                                                                    .selectedTransporter.length));
                                                                index++)
                                                              controller
                                                                      .invitedController[
                                                                          index]
                                                                      .text
                                                                      .isEmpty
                                                                  ? SizedBox
                                                                      .shrink()
                                                                  : wrapItem(
                                                                      controller
                                                                          .invitedController[
                                                                              index]
                                                                          .text,
                                                                      () {
                                                                      controller
                                                                          .removeInvitedController(
                                                                              index);
                                                                      controller
                                                                          .totalInvited
                                                                          .value--;
                                                                      controller
                                                                          .updateJumlahMitra();
                                                                    },
                                                                      email:
                                                                          true),
                                                            controller.jumlahMitra
                                                                        .value <=
                                                                    controller
                                                                        .limitTampil
                                                                ? SizedBox
                                                                    .shrink()
                                                                : GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      controller
                                                                          .toListUser();
                                                                    },
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(
                                                                                15)),
                                                                            border: Border.all(
                                                                                width:
                                                                                    2,
                                                                                color: Color(ListColor
                                                                                    .colorDarkGrey))),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                6,
                                                                            vertical:
                                                                                4),
                                                                        child: CustomText(
                                                                            "+ " +
                                                                                (controller.jumlahMitra.value - controller.limitTampil).toString(),
                                                                            fontSize: 12)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              right: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  4,
                                                              bottom: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  4),
                                                          child: GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .removeAll(),
                                                              child: Icon(
                                                                  Icons.close,
                                                                  size: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      12,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorDarkGrey3))),
                                                        )))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Obx(
                                        () => Column(
                                          children: [
                                            !controller.showSemua.value
                                                ? SizedBox.shrink()
                                                : Obx(
                                                    () => Column(
                                                      children: [
                                                        Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            dividerColor: Colors
                                                                .transparent,
                                                          ),
                                                          child: Obx(
                                                            () => ExpansionTile(
                                                              title: CustomText(
                                                                "Pilih Semua",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorDarkGrey3),
                                                              ),
                                                              trailing: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .black),
                                                              onExpansionChanged:
                                                                  (value) {
                                                                controller
                                                                    .isExpandJenisMitra
                                                                    .value = value;
                                                              },
                                                              initiallyExpanded:
                                                                  true,
                                                              children: [
                                                                !controller
                                                                        .isExpandJenisMitra
                                                                        .value
                                                                    ? SizedBox
                                                                        .shrink()
                                                                    : _lineSeparator(),
                                                                Wrap(
                                                                  children: [
                                                                    FractionallySizedBox(
                                                                        widthFactor:
                                                                            0.45,
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Obx(
                                                                              () => CheckBoxCustom(
                                                                                size: 14,
                                                                                shadowSize: 16,
                                                                                isWithShadow: true,
                                                                                value: controller.selectedJenisMitra.values.toList().contains("Semua Transporter"),
                                                                                onChanged: (checked) {
                                                                                  if (checked) {
                                                                                    controller.selectedJenisMitra.addAll({
                                                                                      "0": "Semua Transporter"
                                                                                    });
                                                                                  } else {
                                                                                    controller.selectedJenisMitra.removeWhere((key, value) => value == "Semua Transporter");
                                                                                  }
                                                                                  controller.updateJumlahMitra();
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                            ),
                                                                            CustomText(
                                                                              "Semua Transporter",
                                                                              fontSize: 12,
                                                                              color: Color(ListColor.colorGrey4),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    FractionallySizedBox(
                                                                        widthFactor:
                                                                            0.45,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Obx(
                                                                              () => CheckBoxCustom(
                                                                                size: 14,
                                                                                shadowSize: 16,
                                                                                isWithShadow: true,
                                                                                value: controller.selectedJenisMitra.values.toList().contains("Semua Mitra"),
                                                                                onChanged: (checked) {
                                                                                  if (checked) {
                                                                                    controller.selectedJenisMitra.addAll({
                                                                                      "1": "Semua Mitra"
                                                                                    });
                                                                                  } else {
                                                                                    controller.selectedJenisMitra.removeWhere((key, value) => value == "Semua Mitra");
                                                                                  }
                                                                                  controller.updateJumlahMitra();
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                            ),
                                                                            CustomText(
                                                                              "Semua Mitra",
                                                                              fontSize: 12,
                                                                              color: Color(ListColor.colorGrey4),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        controller
                                                                .isExpandJenisMitra
                                                                .value
                                                            ? SizedBox.shrink()
                                                            : _lineSeparator(),
                                                      ],
                                                    ),
                                                  ),
                                            controller.listGroupSearch.length ==
                                                    0
                                                ? SizedBox.shrink()
                                                : Obx(
                                                    () => Column(
                                                      children: [
                                                        Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            dividerColor: Colors
                                                                .transparent,
                                                          ),
                                                          child: Obx(
                                                            () => ExpansionTile(
                                                              title: CustomText(
                                                                "Group",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorDarkGrey3),
                                                              ),
                                                              trailing: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .black),
                                                              onExpansionChanged:
                                                                  (value) {
                                                                controller
                                                                    .isExpandGroup
                                                                    .value = value;
                                                              },
                                                              initiallyExpanded:
                                                                  true,
                                                              children: [
                                                                !controller
                                                                        .isExpandGroup
                                                                        .value
                                                                    ? SizedBox
                                                                        .shrink()
                                                                    : _lineSeparator(),
                                                                Wrap(
                                                                  children: [
                                                                    for (var index =
                                                                            0;
                                                                        index <
                                                                            controller
                                                                                .listGroupSearch.length;
                                                                        index++)
                                                                      FractionallySizedBox(
                                                                          widthFactor:
                                                                              0.45,
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Obx(
                                                                                () => CheckBoxCustom(
                                                                                  size: 14,
                                                                                  shadowSize: 16,
                                                                                  isWithShadow: true,
                                                                                  value: controller.selectedGroup.value.any((element) => element["ID"] == controller.listGroupSearch[index]["ID"]),
                                                                                  onChanged: (checked) {
                                                                                    if (checked) {
                                                                                      controller.selectedGroup.add(controller.listGroupSearch[index]);
                                                                                    } else {
                                                                                      controller.selectedGroup.removeWhere((element) => element["ID"] == controller.listGroupSearch[index]["ID"]);
                                                                                    }
                                                                                    controller.updateJumlahMitra();
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                              ),
                                                                              Expanded(
                                                                                child: Obx(
                                                                                  () => SubstringHighlight(text: controller.listGroupSearch[index]["Name"], term: controller.transporterSearch.value, textStyle: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, color: Color(ListColor.colorGrey4)), textStyleHighlight: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, color: Color(ListColor.color4), fontWeight: FontWeight.bold)),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        controller.isExpandGroup
                                                                .value
                                                            ? SizedBox.shrink()
                                                            : _lineSeparator(),
                                                      ],
                                                    ),
                                                  ),
                                            controller.listTransporterSearch
                                                        .length ==
                                                    0
                                                ? SizedBox.shrink()
                                                : Obx(
                                                    () => Column(
                                                      children: [
                                                        Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            dividerColor: Colors
                                                                .transparent,
                                                          ),
                                                          child: Obx(
                                                            () => ExpansionTile(
                                                              title: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CustomText(
                                                                    "Mitra",
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorDarkGrey3),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                4),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      "assets/ic_mitra.svg",
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                    ),
                                                                  ),
                                                                  CustomText(
                                                                    "/ Transporter",
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorDarkGrey3),
                                                                  ),
                                                                ],
                                                              ),
                                                              trailing: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .black),
                                                              onExpansionChanged:
                                                                  (value) {
                                                                controller
                                                                    .isExpandTransporter
                                                                    .value = value;
                                                              },
                                                              initiallyExpanded:
                                                                  true,
                                                              children: [
                                                                !controller
                                                                        .isExpandTransporter
                                                                        .value
                                                                    ? SizedBox
                                                                        .shrink()
                                                                    : _lineSeparator(),
                                                                Wrap(
                                                                  children: [
                                                                    for (var index =
                                                                            0;
                                                                        index <
                                                                            (controller.listTransporterSearch.length > controller.limitTransporter
                                                                                ? controller.limitTransporter
                                                                                : controller.listTransporterSearch.length);
                                                                        index++)
                                                                      FractionallySizedBox(
                                                                          widthFactor: 0.45,
                                                                          child: Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Obx(
                                                                                () => CheckBoxCustom(
                                                                                  size: 14,
                                                                                  shadowSize: 16,
                                                                                  isWithShadow: true,
                                                                                  value: controller.selectedTransporter.any((element) => element["id"] == controller.listTransporterSearch[index]["id"]),
                                                                                  onChanged: (checked) {
                                                                                    if (checked) {
                                                                                      controller.selectedTransporter.add(controller.listTransporterSearch[index]);
                                                                                    } else {
                                                                                      controller.selectedTransporter.removeWhere((element) => element["id"] == controller.listTransporterSearch[index]["id"]);
                                                                                    }
                                                                                    controller.updateJumlahMitra();
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                              ),
                                                                              Expanded(
                                                                                child: Obx(
                                                                                  () => SubstringHighlight(text: controller.listTransporterSearch[index]["name"] == null ? "--null--" : controller.listTransporterSearch[index]["name"], term: controller.transporterSearch.value, textStyle: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, color: Color(ListColor.colorGrey4)), textStyleHighlight: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, color: Color(ListColor.color4), fontWeight: FontWeight.bold)),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        controller
                                                                .isExpandTransporter
                                                                .value
                                                            ? SizedBox.shrink()
                                                            : _lineSeparator(),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets.fromLTRB(
                                                              GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  16,
                                                              GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  8,
                                                              GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  16,
                                                              0),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  14,
                                                              vertical: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  3),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    6),
                                                            border: Border.all(
                                                                width: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    1,
                                                                color: Color(
                                                                    ListColor
                                                                        .color4)),
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              CustomText(
                                                                  "Terdapat ${controller.listTransporterSearch.length} mitra/transporter",
                                                                  height: 1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  color: Color(
                                                                      ListColor
                                                                          .color4)),
                                                              CustomText(
                                                                  "Gunakan pencarian untuk mencari mitra/transporter",
                                                                  height: 1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  color: Color(
                                                                      ListColor
                                                                          .color4)),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                            Container(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  15,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                  ),
                                                  child: CheckBoxCustom(
                                                    size: 14,
                                                    shadowSize: 16,
                                                    isWithShadow: true,
                                                    value: controller
                                                            .totalInvited
                                                            .value >
                                                        0,
                                                    onChanged: (value) {
                                                      if (value) {
                                                        controller
                                                            .addInvitedController();
                                                        controller.totalInvited
                                                            .value++;
                                                      } else {
                                                        controller.totalInvited
                                                            .value = 0;
                                                        controller
                                                            .invitedController
                                                            .clear();
                                                        controller.errorInvited
                                                            .clear();
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          5,
                                                ),
                                                CustomText(
                                                  "Invited Transporter",
                                                  fontSize: 12,
                                                  color: Color(
                                                      ListColor.colorGrey4),
                                                ),
                                              ],
                                            ),
                                            Obx(() => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    for (var index = 0;
                                                        index <
                                                            controller
                                                                .totalInvited
                                                                .value;
                                                        index++)
                                                      Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  16,
                                                              vertical: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                          child: Obx(
                                                            () => Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            40,
                                                                        child:
                                                                            CustomText(
                                                                          "Email",
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Color(ListColor.colorGrey4),
                                                                        )),
                                                                    Expanded(
                                                                      child:
                                                                          Focus(
                                                                        onFocusChange:
                                                                            (onFocus) {
                                                                          if (!onFocus) {
                                                                            if (controller.emailRegex.hasMatch(controller.invitedController[index].text)) {
                                                                              controller.errorInvited.removeWhere((element) => element == index);
                                                                            } else {
                                                                              controller.errorInvited.add(index);
                                                                            }
                                                                          }
                                                                        },
                                                                        child: CustomTextField(
                                                                            context: context,
                                                                            textSize: 12,
                                                                            controller: controller.invitedController[index],
                                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                            newInputDecoration: InputDecoration(
                                                                                isDense: true,
                                                                                isCollapsed: true,
                                                                                hintStyle: TextStyle(color: Color(ListColor.colorLightGrey2), fontWeight: FontWeight.w600),
                                                                                disabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1.0),
                                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1.0),
                                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1.0),
                                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                ),
                                                                                errorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1.0),
                                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                ),
                                                                                focusedErrorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: GlobalVariable.ratioWidth(Get.context) * 1.0),
                                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                ),
                                                                                contentPadding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 6, vertical: GlobalVariable.ratioWidth(Get.context) * 8))),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20,
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20,
                                                                      margin: EdgeInsets.only(
                                                                          left: GlobalVariable.ratioWidth(Get.context) *
                                                                              10,
                                                                          right:
                                                                              GlobalVariable.ratioWidth(Get.context) * 14),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          controller
                                                                              .removeInvitedController(index);
                                                                          controller
                                                                              .totalInvited
                                                                              .value--;
                                                                        },
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "assets/icon_remove_red.svg",
                                                                          width:
                                                                              GlobalVariable.ratioWidth(Get.context) * 20,
                                                                          height:
                                                                              GlobalVariable.ratioWidth(Get.context) * 20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20,
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20,
                                                                      child: index !=
                                                                              (controller.totalInvited.value -
                                                                                  1)
                                                                          ? SizedBox
                                                                              .shrink()
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                controller.addInvitedController();
                                                                                controller.totalInvited.value++;
                                                                              },
                                                                              child: SvgPicture.asset(
                                                                                "assets/icon_add_blue.svg",
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 20,
                                                                                height: GlobalVariable.ratioWidth(Get.context) * 20,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                !controller
                                                                        .errorInvited
                                                                        .contains(
                                                                            index)
                                                                    ? SizedBox
                                                                        .shrink()
                                                                    : Container(
                                                                        margin: EdgeInsets.only(
                                                                            left: GlobalVariable.ratioWidth(Get.context) *
                                                                                40),
                                                                        child:
                                                                            CustomText(
                                                                          "Format email tidak benar",
                                                                          color:
                                                                              Color(ListColor.colorRed),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ))
                                                              ],
                                                            ),
                                                          ))
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  side: BorderSide(
                                      color: Color(ListColor.color4),
                                      width: 2)),
                              onPressed: () {
                                Get.back();
                              },
                              child: CustomText("Cancel",
                                  color: Color(ListColor.color4)))),
                      Container(width: 10),
                      Expanded(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              color: Color(ListColor.color4),
                              onPressed: () {
                                FocusScope.of(Get.context).unfocus();
                                FocusManager.instance.primaryFocus.unfocus();
                                var listInvited = {};
                                var index = 0;
                                controller.errorInvited.value
                                    .forEach((element) {
                                  if (element.text.isNotEmpty) {
                                    listInvited[index] = element.text;
                                    index++;
                                  }
                                });
                                Get.back(result: {
                                  "semua": controller.selectedJenisMitra,
                                  "group": controller.selectedGroup,
                                  "transporter": controller.selectedTransporter,
                                  "invited": listInvited
                                });
                              },
                              child:
                                  CustomText("Terapkan", color: Colors.white)))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget wrapItem(String text, Function onDelete, {bool email = false}) {
    return Container(
        decoration: BoxDecoration(
          color: Color(
              email ? ListColor.colorLightGrey2 : ListColor.colorLightGrey10),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 4,
            GlobalVariable.ratioWidth(Get.context) * 2,
            GlobalVariable.ratioWidth(Get.context) * 2,
            GlobalVariable.ratioWidth(Get.context) * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(ListColor.colorLightGrey4)),
            Container(width: GlobalVariable.ratioWidth(Get.context) * 4),
            GestureDetector(
                onTap: () {
                  onDelete();
                },
                child: Icon(
                  Icons.close,
                  size: GlobalVariable.ratioWidth(Get.context) * 14,
                  color: Color(ListColor.colorDarkGrey3),
                )),
          ],
        ));
  }

  Widget _lineSeparator() {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 5,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        height: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey21));
  }
}
