import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'choose_ekspetasi_destinasi_controller.dart';

class ChooseEkspetasiDestinasiView
    extends GetView<ChooseEkspetasiDestinasiController> {
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
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
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
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Obx(
                                () => CustomTextField(
                                    context: Get.context,
                                    newContentPadding:
                                        EdgeInsets.fromLTRB(42, 10, 10, 10),
                                    onChanged: (value) {
                                      controller.addTextSearchCity(value);
                                    },
                                    controller: controller
                                        .searchTextEditingController.value,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      controller.onSubmitSearch();
                                    },
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      hintText: controller.title.isEmpty
                                          ? "Cari Ekspektasi Destinasi".tr
                                          : controller.title.value,
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
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: controller.isShowClearSearch.value
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onClearSearch();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                24,
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
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Color(ListColor.colorLightBlue5))
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
                    Obx(
                      () => Container(
                          margin: EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                              bottom: (controller.allLocation.value ||
                                      controller.listChoosen.length > 0)
                                  ? 16
                                  : 0),
                          child: Obx(
                            () => CustomText(
                                controller.title.isEmpty
                                    ? "Ekspektasi Destinasi"
                                    : controller.title.value,
                                color: Color(ListColor.colorGrey3),
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: controller.allLocation.value
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(ListColor.colorLightGrey10)),
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: CustomText("Siap kemana saja",
                                            fontWeight: FontWeight.w500,
                                            color: Color(ListColor.colorGrey4),
                                            fontSize: 12)),
                                    GestureDetector(
                                      onTap: () {
                                        controller.allLocation.value = false;
                                      },
                                      child: Icon(Icons.close,
                                          color: Colors.black, size: 12),
                                    ),
                                  ],
                                ),
                              )
                            : controller.listChoosen.length == 0
                                ? SizedBox.shrink()
                                : ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: double.infinity,
                                        minHeight: 30,
                                        maxHeight: 128),
                                    child: Scrollbar(
                                      isAlwaysShown: true,
                                      child: SingleChildScrollView(
                                        child: Obx(() => Wrap(
                                              alignment: WrapAlignment.start,
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: [
                                                for (var index = 0;
                                                    index <
                                                        controller
                                                            .listChoosen.length;
                                                    index++)
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Color(ListColor
                                                            .colorLightGrey10)),
                                                    padding: EdgeInsets.all(6),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            child: CustomText(
                                                                controller
                                                                        .listChoosen
                                                                        .values
                                                                        .toList()[
                                                                    index],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                                fontSize: 12)),
                                                        GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .listChoosen
                                                                .removeWhere((key,
                                                                        value) =>
                                                                    key ==
                                                                    controller
                                                                        .listChoosen
                                                                        .keys
                                                                        .toList()[index]);
                                                          },
                                                          child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                              size: 12),
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
                    controller.allLocation.value ||
                            controller.listChoosen.keys.length > 0
                        ? Container(
                            height: 2,
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 18),
                            color: Color(ListColor.colorLightGrey5WithOpacity))
                        : SizedBox.shrink(),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child: GestureDetector(
                          onTap: () {
                            if (!controller.allLocation.value) {
                              controller.listChoosen.clear();
                              controller.allLocation.value = true;
                            } else {
                              controller.allLocation.value = false;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomText("Siap kemana saja",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(width: 5),
                              Obx(
                                () => CheckBoxCustom(
                                    size: 16,
                                    shadowSize: 18,
                                    isWithShadow: true,
                                    value: controller.allLocation.value,
                                    onChanged: (value) {
                                      if (value) {
                                        controller.listChoosen.clear();
                                      }
                                      controller.allLocation.value = value;
                                    }),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 2,
                        color: Color(ListColor.colorLightGrey5WithOpacity)),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.listLocation.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          controller.onCheckCity(
                                              index,
                                              !controller.listChoosen
                                                  .containsKey(controller
                                                      .listLocation.keys
                                                      .elementAt(index)));
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 24,
                                                child: Obx(
                                                  () => CustomText(
                                                      controller.getInitial(
                                                          controller
                                                              .listLocation.keys
                                                              .elementAt(
                                                                  index)),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: controller
                                                              .allLocation.value
                                                          ? Color(ListColor
                                                              .colorGrey2)
                                                          : Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Expanded(
                                                child: Stack(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    children: [
                                                      CustomText(
                                                          controller
                                                              .listLocation
                                                              .values
                                                              .elementAt(index),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                      CustomText("\n",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                          fontSize: 14)
                                                    ]),
                                              ),
                                              SizedBox(width: 5),
                                              Obx(
                                                () => CheckBoxCustom(
                                                    size: 16,
                                                    shadowSize: 18,
                                                    isWithShadow: true,
                                                    value: controller
                                                        .listChoosen
                                                        .containsKey(controller
                                                            .listLocation.keys
                                                            .elementAt(index)),
                                                    onChanged: (value) {
                                                      controller.onCheckCity(
                                                          index, value);
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 24, right: 4),
                                      width: MediaQuery.of(context).size.width,
                                      height: 0.5,
                                      color: Color(ListColor.colorLightGrey5),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 23),
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
                                controller.resetAll();
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
                            width: 10,
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
                                controller.onSubmit();
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
              controller.listLocation.length == 0
                  ? Positioned.fill(
                      child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: CustomText("Data Tidak Ditemukan")))
                  : SizedBox.shrink(),
              controller.loading.value
                  ? Positioned.fill(
                      child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()))
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
