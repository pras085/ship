import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoFilterJenisTrukLelangMuatanView
    extends GetView<ZoFilterJenisTrukLelangMuatanController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Container(
            height: 64,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ], color: Colors.white),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 20,
                      10,
                      GlobalVariable.ratioWidth(Get.context) * 20,
                      5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Color(ListColor.color4),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: GlobalVariable.ratioFontSize(
                                                context) *
                                            19,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 12,
                      ),
                      Obx(
                        () => Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Obx(
                                () => CustomTextField(
                                    key: ValueKey(
                                        "cari ${controller.title.value}"),
                                    context: Get.context,
                                    newContentPadding:
                                        EdgeInsets.fromLTRB(42, 10, 10, 10),
                                    onChanged: (value) {
                                      controller.onChange(value);
                                    },
                                    controller: controller
                                        .searchTextEditingController.value,
                                    textInputAction: TextInputAction.search,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    onSubmitted: (value) {
                                      controller.onChange(value);
                                    },
                                    textSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2)),
                                      hintText:
                                          "LelangMuatBuatLelangBuatLelangLabelTitleCari"
                                                  .tr +
                                              " " +
                                              controller.title.value,
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor.color4),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  "assets/search_magnifition_icon.svg",
                                  width: GlobalVariable.ratioFontSize(context) *
                                      28,
                                  height:
                                      GlobalVariable.ratioFontSize(context) *
                                          28,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: controller.isShowClearSearch.value
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onChange("");
                                          controller
                                              .searchTextEditingController.value
                                              .clear();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                28,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(context) * 20,
                    ),
                    Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 20),
                        child: controller.listSelectedLocation.length == 0
                            ? SizedBox.shrink()
                            : ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: double.infinity,
                                    minHeight: 30,
                                    maxHeight: 107),
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  child: SingleChildScrollView(
                                    child: Obx(() => Wrap(
                                          alignment: WrapAlignment.start,
                                          spacing: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          runSpacing: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              10,
                                          children: [
                                            for (var index = 0;
                                                index <
                                                    controller
                                                        .listSelectedLocation
                                                        .length;
                                                index++)
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Color(ListColor
                                                        .colorLightGrey10)),
                                                padding: EdgeInsets.fromLTRB(
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        1,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        1),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: GlobalVariable.ratioWidth(Get
                                                                    .context) *
                                                                4),
                                                        child: CustomText(
                                                            controller.listSelectedLocation[index]
                                                                ["Description"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(ListColor
                                                                .colorGrey4),
                                                            fontSize:
                                                                GlobalVariable.ratioFontSize(
                                                                        context) *
                                                                    12)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .listSelectedLocation
                                                            .removeAt(index);
                                                      },
                                                      child: Icon(Icons.close,
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          size: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    controller.listSelectedLocation.length > 0
                        ? Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    14),
                            color: Color(ListColor.colorLightGrey10))
                        : SizedBox.shrink(),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.listTempLocation.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          if (controller.listSelectedLocation
                                              .any((element) =>
                                                  element["Description"] ==
                                                  controller.listTempLocation[
                                                      index]["Description"])) {
                                            controller.listSelectedLocation
                                                .removeWhere((element) =>
                                                    element["Description"] ==
                                                    controller.listTempLocation[
                                                        index]["Description"]);
                                          } else {
                                            controller.listSelectedLocation.add(
                                                controller
                                                    .listTempLocation[index]);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          context) *
                                                      12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            context) *
                                                        59,
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            context) *
                                                        65,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(8)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Color(ListColor
                                                            .colorLightGrey2))),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  child: Image.network(
                                                    controller
                                                        .listTempLocation[index]
                                                            [controller
                                                                .nameimg.value]
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            context) *
                                                        24,
                                              ),
                                              // Container(
                                              //   width: 24,
                                              //   child: Obx(
                                              //     () => CustomText(
                                              //         controller.listTempLocation[
                                              //             index]["Initial"],
                                              //         fontWeight:
                                              //             FontWeight.w600,
                                              //         color: index == 0 ||
                                              //                 (controller.listTempLocation[index]
                                              //                         [
                                              //                         "Initial"] !=
                                              //                     controller.listTempLocation[
                                              //                             index -
                                              //                                 1]
                                              //                         ["Initial"])
                                              //             ? Colors.black
                                              //             : Colors.transparent,
                                              //         fontSize: 14),
                                              //   ),
                                              // ),
                                              Expanded(
                                                child: Stack(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    children: [
                                                      CustomText(
                                                          controller.listTempLocation[
                                                                  index]
                                                              ["Description"],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              14),
                                                      CustomText("\n",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              14)
                                                    ]),
                                              ),
                                              SizedBox(width: 5),
                                              Obx(
                                                () => CheckBoxCustom(
                                                    size: 15,
                                                    shadowSize: 19,
                                                    isWithShadow: true,
                                                    border: 1,
                                                    colorBG: Colors.white,
                                                    borderColor:
                                                        Color(ListColor.color4),
                                                    value: controller
                                                        .listSelectedLocation
                                                        .any((element) =>
                                                            element[
                                                                "Description"] ==
                                                            controller.listTempLocation[
                                                                    index][
                                                                "Description"]),
                                                    onChanged: (value) {
                                                      if (value) {
                                                        controller
                                                            .listSelectedLocation
                                                            .add(controller
                                                                    .listTempLocation[
                                                                index]);
                                                      } else {
                                                        controller
                                                            .listSelectedLocation
                                                            .removeWhere((element) =>
                                                                element[
                                                                    "Description"] ==
                                                                controller.listTempLocation[
                                                                        index][
                                                                    "Description"]);
                                                      }
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 4),
                                      width: MediaQuery.of(context).size.width,
                                      height: 0.5,
                                      color: Color(ListColor.colorLightGrey10),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 23,
                          GlobalVariable.ratioWidth(Get.context) * 10,
                          GlobalVariable.ratioWidth(Get.context) * 23,
                          GlobalVariable.ratioWidth(Get.context) * 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color(ListColor.colorLightGrey)
                                  .withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 4,
                            ),
                          ]),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(
                                      width: 2, color: Color(ListColor.color4)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  )),
                              onPressed: () {
                                controller.onReset();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomText(
                                          "GlobalButtonResetSearchCity".tr,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.color4)),
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 10,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(ListColor.color4),
                                  side: BorderSide(
                                      width: 2, color: Color(ListColor.color4)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  )),
                              onPressed: () {
                                controller.onSave();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomText(
                                          "GlobalButtonSaveSearchCity".tr,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              controller.listTempLocation.length == 0
                  ? Positioned.fill(
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: SvgPicture.asset(
                                "assets/ic_management_lokasi_no_search.svg",
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    82.3,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 75,
                              )),
                              Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                              Container(
                                  child: CustomText(
                                "LocationManagementLabelNoKeywordFoundFilter"
                                    .tr
                                    .replaceAll("\\n", "\n"),
                                textAlign: TextAlign.center,
                                color: Color(ListColor.colorLightGrey14),
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioFontSize(context) * 14,
                                height: 1.2,
                              ))
                            ],
                          )))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
